import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:o_learning_x/configs/config.dart';
import 'package:o_learning_x/cores/shared_preferences.dart';
import 'package:o_learning_x/models/question_model.dart';
import 'package:o_learning_x/models/quiz_model.dart';
import 'package:o_learning_x/models/sub_module_model.dart';
import 'package:o_learning_x/repositories/base_repository.dart';
import 'package:o_learning_x/repositories/types.dart';
import 'package:o_learning_x/utils/object_helper.dart';
import 'package:o_learning_x/utils/requester.dart';
import 'package:o_learning_x/utils/time_helper.dart';

class QuizRepository extends BaseDataRepository<QuizModel> {
  final BuildContext buildCtx;
  final IConfig config;
  final IRepositoryOptions options;
  final ISharedPreferences sharedPreferences;

  late bool expandQuiz;
  late bool answerWrongAlert;
  late bool isInitial;
  late bool isAnswersInitial;
  late String currentQuestionId;
  late String currentChoiceId;
  late String currentQuizId;
  late int receivePoint;
  late List<Map<String, dynamic>> answers;
  late List<Map<String, dynamic>> answerIds;
  late List<Map<String, dynamic>> choiceIds;

  QuizRepository({
    required this.buildCtx,
    required this.config,
    required this.options,
    required this.sharedPreferences,
  }) : super(buildCtx, config, options, sharedPreferences) {
    this.expandQuiz = false;
    this.answerWrongAlert = false;
    this.isInitial = false;
    this.isAnswersInitial = false;
    this.currentQuestionId = '';
    this.currentChoiceId = '';
    this.currentQuizId = '';
    this.receivePoint = 0;
    this.answers = List<Map<String, dynamic>>.empty(growable: true);
    this.answerIds = List<Map<String, dynamic>>.empty(growable: true);
    this.choiceIds = List<Map<String, dynamic>>.empty(growable: true);
  }

  QuestionModel? get currentQuestion =>
      this.findQuestionById(this.currentQuestionId);

  QuestionModel? findQuestionById(String questionId) {
    try {
      return this
          .data
          ?.Questions
          .singleWhere((question) => question.Id == questionId, orElse: null);
    } catch (e) {
      return null;
    }
  }

  initialChoices() {
    if (!this.isAnswersInitial) {
      this.answerIds = List.generate(
          this.currentQuestion?.Choices?.length ?? 0,
          (index) => {
                "label": "",
                "value": "",
              });
      this.choiceIds = List.generate(
          this.currentQuestion?.Choices?.length ?? 0,
          (index) => {
                "label": this.currentQuestion?.Choices?[index].ChoiceText ?? "",
                "value": this.currentQuestion?.Choices?[index].ChoiceId ?? "",
              });

      this.isAnswersInitial = true;
    }
  }

  bool isAnswerAdded(String choiceId) {
    return this.answerIds.singleWhere((answer) => answer['value'] == choiceId,
            orElse: () =>
                Map<String, dynamic>.from({"invalid": true}))["invalid"] !=
        true;
  }

  void answerEssayQuestion(Map<String, dynamic> choiceId) {
    int index = this.answerIds.indexWhere((answer) => answer["value"] == "");
    this.answerIds[index] = choiceId;
  }

  bool get canAnswer {
    if (this.currentQuestion == null) {
      return true;
    } else if (this.currentQuestion?.type == ChoiceType.ESSAY) {
      return this.answerIds.where((answer) => answer['value'] == '').isEmpty;
    } else if (this.currentQuestion?.type == ChoiceType.CHOICE) {
      return this.currentChoiceId != '';
    } else {
      return true;
    }
  }

  @override
  Future<void> get(String id,
      {Map<String, dynamic>? params, bool isMock: false}) async {
    this.currentQuizId = id;
    String quizId = id;
    String quizKey = "default";
    List<SubModuleModel>? subModules = params?["sub_modules"];
    if (subModules != null) {
      params?.remove("sub_modules");
    }
    if (subModules != null) {
      for (int i = 0; i < subModules.length; i++) {
        if (subModules[i].Current < subModules[i].Max) {
          quizId = subModules[i].Id;
          quizKey = subModules[i].Id;
          this.currentQuizId = subModules[i].Id;
          break;
        }
      }
    }

    try {
      this.toLoadingStatus();
      late Map<String, dynamic> data;

      if (params == null) {
        params = {};
      }

      if (isMock) {
        await TimeHelper.sleep();
        Map<String, dynamic> mock = this
            .options
            .getMockItems()!
            .firstWhere((element) => id == element["product_id"]);
        data = {"data": mock};
      } else {
        Response response = await Requester.get(
          "${this.config.baseAPI()}/submodule/title/$quizId",
          params: params,
          headers: this.sharedPreferences.getAuthentication(),
        );
        List<dynamic> js = json.decode(utf8.decode(response.bodyBytes));
        data = {
          "data": {"questions": js}
        };
      }

      setInnerData(data["data"]);
      this.dataSC.add(this.data);

      this.toLoadedStatus();
    } catch (e) {
      this.alertError(e);
      this.toErrorStatus(e);
    }
  }

  void answerQuestion() {
    QuestionModel? questionItem = this.findQuestionById(this.currentQuestionId);
    bool isCorrect = false;

    if (questionItem != null) {
      switch (questionItem.type) {
        case ChoiceType.ESSAY:
          int index = 0;

          questionItem.CorrectChoiceIds?.forEach((_, correct) {
            if (correct != this.answerIds[index]['value']) {
              answerWrongAlert = true;
            }

            index++;
          });

          if (!this.answerWrongAlert) {
            isCorrect = true;
          }

          break;
        case ChoiceType.CHOICE:
          if (questionItem.CorrectChoiceId != this.currentChoiceId) {
            answerWrongAlert = true;
          }
          break;
        default:
      }

      switch (questionItem.type) {
        case ChoiceType.READING:
          isCorrect = true;
          break;
        case ChoiceType.ESSAY:
          break;
        case ChoiceType.CHOICE:
          isCorrect = questionItem.CorrectChoiceId != this.currentChoiceId;
          break;
        default:
          isCorrect = false;
      }

      this.answers = [
        ...this.answers,
        {
          'question_id': this.currentQuestionId,
          'type': this.currentQuestion?.TypeString,
          'choice_id': this.currentChoiceId,
          'score': questionItem.Score ?? 0,
          'is_correct': isCorrect,
        }
      ];
    }
  }

  void tryAgain() {
    this.answers.removeLast();
    this.answerWrongAlert = false;
    this.forceValueNotify();
  }

  void resetChoice() {
    this.answerIds = List.generate(
      this.currentQuestion?.Choices?.length ?? 0,
      (index) => {
        'label': '',
        'value': '',
      },
    );
  }

  void resetAnswer() {
    this.answers.clear();
  }

  void expandQuizFeature() {
    this.expandQuiz = true;
  }

  void hideQuizFeature() {
    this.expandQuiz = false;
  }

  Future submitAnswer() async {
    this.toLoadingStatus();

    this.receivePoint = 0;
    List<Map<String, dynamic>> answers =
        List<Map<String, dynamic>>.empty(growable: true);
    this.answers.forEach((raw) {
      answers.add(ObjectHelper.toMap(raw));
    });

    for (int i = 0; i < answers.length; i++) {
      DateTime now = DateTime.now();
      String dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss").format(now);

      try {
        await Requester.post(
            "${this.config.baseAPI()}/learning_progress/title", {
          "status": "1",
          "title_id": answers[i]['question_id'],
          "title_type": answers[i]['type'],
          "start_time": dateFormat,
          "finish_time": dateFormat,
          "star": 1,
        }, headers: this.sharedPreferences.getAuthentication());
        this.receivePoint++;
      } catch (e) {
        print('get category detail error $e');
        this.toErrorStatus(e);
      }
    }
  }

  disposeChoices() {
    this.answerIds.clear();
    this.choiceIds.clear();
    this.isAnswersInitial = false;
  }

  @override
  List<QuizModel> transforms(tss) {
    return QuizModel.toList(tss);
  }

  @override
  QuizModel? transform(ts) {
    return QuizModel.fromJson(ts);
  }
}
