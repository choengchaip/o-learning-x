import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_learning_x/configs/config.dart';
import 'package:o_learning_x/cores/context.dart';
import 'package:o_learning_x/models/question_model.dart';
import 'package:o_learning_x/styles/colors.dart';
import 'package:o_learning_x/styles/fonts.dart';
import 'package:o_learning_x/widgets/commons/cached_image.dart';

class QuizItemEssay extends StatefulWidget {
  final IContext context;
  final IConfig config;
  final QuestionModel questionItem;

  QuizItemEssay({
    required this.context,
    required this.config,
    required this.questionItem,
  });

  @override
  State<StatefulWidget> createState() {
    return _QuizItemEssayState();
  }
}

class _QuizItemEssayState extends State<QuizItemEssay> {
  @override
  void initState() {
    widget.context.repositories().quizRepository().initialChoices();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        CachedImage(
          image: widget.questionItem.ImageURL,
        ),
        Container(
          color: Colors.white,
          padding: EdgeInsets.all(16),
          child: Text(
            widget.questionItem.Question ?? "",
            style: TextStyle(
              fontSize: p,
            ),
          ),
        ),
        if (widget.questionItem.Code != null)
          Container(
            color: colorGrayDark,
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.questionItem.Code ?? "",
                  style: TextStyle(
                    fontSize: p,
                    color: Colors.white,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 6,
                  ),
                  child: Row(
                    children: List.generate(
                      widget.context
                          .repositories()
                          .quizRepository()
                          .answerIds
                          .length,
                      (index) {
                        return Container(
                          margin: EdgeInsets.only(
                            right: 4,
                          ),
                          decoration: BoxDecoration(
                            color: colorSecondary,
                            borderRadius: BorderRadius.all(
                              Radius.circular(4),
                            ),
                          ),
                          padding: EdgeInsets.only(
                            top: 1,
                            bottom: 1,
                            left: 4,
                            right: 4,
                          ),
                          child: Text(
                            widget.context
                                    .repositories()
                                    .quizRepository()
                                    .answerIds[index]["label"] ??
                                "",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: p,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
