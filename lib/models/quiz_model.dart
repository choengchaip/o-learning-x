// ignore_for_file: non_constant_identifier_names
import 'package:o_learning_x/models/question_model.dart';

class QuizModel {
  final int TotalQuestion;
  final List<QuestionModel> Questions;

  QuizModel({
    required this.TotalQuestion,
    required this.Questions,
  });

  factory QuizModel.fromJson(Map<String, dynamic>? rawJson) {
    return QuizModel(
      TotalQuestion: QuestionModel.fromListJson(rawJson?["questions"]).length,
      Questions: QuestionModel.fromListJson(rawJson?["questions"]),
    );
  }

  static List<QuizModel> toList(List<dynamic>? rawItems) {
    if (rawItems == null) {
      return [];
    }

    List<QuizModel> items = [];
    for (int i = 0; i < rawItems.length; i++) {
      items.add(QuizModel.fromJson(rawItems[i]));
    }

    return items;
  }
}