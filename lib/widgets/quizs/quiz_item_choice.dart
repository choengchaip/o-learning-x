import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_learning_x/configs/config.dart';
import 'package:o_learning_x/cores/context.dart';
import 'package:o_learning_x/models/question_model.dart';
import 'package:o_learning_x/styles/colors.dart';
import 'package:o_learning_x/styles/fonts.dart';
import 'package:o_learning_x/widgets/commons/cached_image.dart';

class QuizItemChoice extends StatelessWidget {
  final IContext context;
  final IConfig config;

  final QuestionModel questionItem;
  StreamController<String> answerController = StreamController<String>();

  QuizItemChoice({
    required this.context,
    required this.config,
    required this.questionItem,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        CachedImage(
          image: this.questionItem.ImageURL,
        ),
        Container(
          color: Colors.white,
          padding: EdgeInsets.all(16),
          child: Text(
            this.questionItem.Question ?? "",
            style: TextStyle(
              fontSize: p,
            ),
          ),
        ),
        if (this.questionItem.Code != null)
          Container(
            color: colorSecondary,
            padding: EdgeInsets.all(16),
            child: Text(
              this.questionItem.Code!,
              style: TextStyle(
                fontSize: p,
                color: Colors.white,
              ),
            ),
          ),
        StreamBuilder<String>(
          stream: answerController.stream,
          builder: (context, snapshot) {
            return Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: List.generate(this.questionItem.Choices?.length ?? 0,
                    (int index) {
                  return GestureDetector(
                    onTap: () {
                      if (!this
                          .context
                          .repositories()
                          .quizRepository()
                          .answerWrongAlert) {
                        this
                            .answerController
                            .add(this.questionItem.Choices![index].ChoiceId);
                        this
                                .context
                                .repositories()
                                .quizRepository()
                                .currentChoiceId =
                            this.questionItem.Choices![index].ChoiceId;
                      }
                    },
                    child: Card(
                      shadowColor: snapshot.data ==
                              this.questionItem.Choices![index].ChoiceId
                          ? Colors.transparent
                          : Colors.black,
                      margin: EdgeInsets.only(bottom: 12),
                      color: (snapshot.data ==
                                  this.questionItem.Choices![index].ChoiceId &&
                              this
                                  .context
                                  .repositories()
                                  .quizRepository()
                                  .answerWrongAlert)
                          ? Theme.of(context).primaryColor
                          : snapshot.data ==
                                  this.questionItem.Choices![index].ChoiceId
                              ? Theme.of(context).primaryColorLight
                              : Colors.white,
                      child: Container(
                        padding: EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                          left: 16,
                          right: 16,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          this.questionItem.Choices![index].ChoiceText,
                          style: TextStyle(
                            color: (snapshot.data ==
                                        this
                                            .questionItem
                                            .Choices![index]
                                            .ChoiceId &&
                                    this
                                        .context
                                        .repositories()
                                        .quizRepository()
                                        .answerWrongAlert)
                                ? Colors.white
                                : Colors.black,
                            fontSize: p,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            );
          },
        ),
      ],
    );
  }
}
