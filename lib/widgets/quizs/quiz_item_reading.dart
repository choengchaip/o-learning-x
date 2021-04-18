import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_learning_x/models/question_model.dart';
import 'package:o_learning_x/styles/fonts.dart';
import 'package:o_learning_x/widgets/commons/cached_image.dart';

class QuizItemReading extends StatelessWidget {
  final QuestionModel questionItem;

  QuizItemReading({
    required this.questionItem,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          CachedImage(
            height: 200,
            image: this.questionItem.ImageURL,
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Text(
              this.questionItem.Question ?? '',
              style: TextStyle(
                fontSize: p,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
