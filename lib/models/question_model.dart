// ignore_for_file: non_constant_identifier_names
import 'package:o_learning_x/models/choice_model.dart';
import 'package:o_learning_x/utils/object_helper.dart';

enum ChoiceType {
  READING,
  CHOICE,
  ESSAY,
  TEXT,
}

class QuestionModel {
  final String Id;
  final String Title;
  final String ImageURL;
  final String TypeString;
  final String? Question;
  final String? Note;
  final String? Code;
  final List<ChoiceModel>? Choices;
  final String? CorrectChoiceId;
  final Map<String, String>? CorrectChoiceIds;
  final String? AnswerWrongMessage;
  final int? Score;

  QuestionModel({
    required this.Id,
    required this.Title,
    required this.ImageURL,
    required this.TypeString,
    this.Question,
    this.Note,
    this.Code,
    this.Choices,
    this.CorrectChoiceId,
    this.CorrectChoiceIds,
    this.AnswerWrongMessage,
    this.Score,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> rawJson) {
    return QuestionModel(
      Id: rawJson['title_id'] ?? "",
      Title: rawJson['title_name'] ?? "",
      ImageURL: rawJson['image_url'] ?? "",
      TypeString: rawJson['title_type'] ?? "",
      Question: rawJson['title_description'] ?? "",
      Note: rawJson['note'] ?? "",
      Code: rawJson['code'] ?? "",
      Choices: ChoiceModel.fromListJson(rawJson['choice']) ?? [],
      CorrectChoiceId: QuestionModel.getAnswerChoice(rawJson['choice']),
      CorrectChoiceIds: rawJson['correct_answer_ids'] ?? "",
      AnswerWrongMessage: rawJson['answer_wrong_message'] ?? "",
      Score: rawJson['score'] ?? "",
    );
  }

  ChoiceType get type {
    switch (this.TypeString) {
      case 'CONTENT':
        return ChoiceType.READING;
      case 'QUIZ':
        return ChoiceType.CHOICE;
      case 'essay':
        return ChoiceType.ESSAY;
      case 'text':
        return ChoiceType.TEXT;
      default:
        return ChoiceType.READING;
    }
  }

  static List<QuestionModel> fromListJson(
      List<Map<String, dynamic>>? listRawJson) {
    if (listRawJson == null) {
      return <QuestionModel>[].toList();
    }

    return listRawJson.map((rawJson) {
      return QuestionModel.fromJson(rawJson);
    }).toList();
  }

  static String getAnswerChoice(List<dynamic>? rawJson) {
    if (rawJson == null) {
      return '';
    }

    try {
      return ObjectHelper.toMap(rawJson[0])['answer'];
    } catch (e) {
      throw (e);
    }
  }
}
