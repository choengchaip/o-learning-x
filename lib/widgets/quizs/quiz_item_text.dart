import 'package:flutter/cupertino.dart';
import 'package:o_learning_x/models/question_model.dart';

class QuizItemText extends StatelessWidget {
  final QuestionModel questionItem;

  QuizItemText({
    required this.questionItem,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text(this.questionItem.Question ?? ""),
      ),
    );
  }
}
