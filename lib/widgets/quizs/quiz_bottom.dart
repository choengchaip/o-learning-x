import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_learning_x/configs/config.dart';
import 'package:o_learning_x/cores/context.dart';
import 'package:o_learning_x/repositories/page_repository.dart';
import 'package:o_learning_x/styles/colors.dart';
import 'package:o_learning_x/styles/fonts.dart';

class QuizBottom extends StatelessWidget {
  final IContext context;
  final IConfig config;

  final PageRepository parentPageRepository;
  final Function onNext;
  final Function onSuccess;

  QuizBottom({
    required this.context,
    required this.config,
    required this.parentPageRepository,
    required this.onNext,
    required this.onSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).padding.bottom,
      ),
      child: Column(
        children: [
          AnimatedContainer(
            duration: Duration(
              milliseconds: 250,
            ),
            height: 5,
            color: this.context.repositories().quizRepository().answerWrongAlert ? Colors.red : Colors.green,
          ),
          AnimatedContainer(
            duration: Duration(
              milliseconds: 250,
            ),
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
            ),
            height: this.context.repositories().quizRepository().answerWrongAlert ? 45 : 0,
            child: Text(
              (this.context.repositories().quizRepository().currentQuestion?.Note) ?? 'ANSWER WRONG !!!',
              style: TextStyle(
                fontSize: p,
              ),
            ),
          ),
          AnimatedContainer(
            duration: Duration(
              milliseconds: 250,
            ),
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
            ),
            height: this.context.repositories().quizRepository().choiceIds.isEmpty
                ? 0 : 55,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                  (this.context.repositories().quizRepository().choiceIds.isEmpty
                      ? 0
                      : this.context.repositories().quizRepository().choiceIds.length), (index) {
                return Container(
                  margin: EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () {
                      if (!this.context.repositories().quizRepository().isAnswerAdded(
                          this.context.repositories().quizRepository().choiceIds[index]['value'])) {
                        this.context.repositories().quizRepository().answerEssayQuestion(
                            this.context.repositories().quizRepository().choiceIds[index]);
                      }
                    },
                    child: Card(
                      color: this.context.repositories().quizRepository().choiceIds.isEmpty
                          ? Colors.white
                          : this.context.repositories().quizRepository().isAnswerAdded(
                          this.context.repositories().quizRepository().choiceIds[index]['value'])
                          ? colorGrayLighter
                          : Colors.white,
                      child: Container(
                        padding: EdgeInsets.all(4),
                        child: Text(this.context.repositories().quizRepository().choiceIds[index]['label']),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: 12,
              left: 8,
              right: 8,
            ),
            margin: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: colorGrayLighter,
                ),
              ),
            ),
            height: 65,
            child: Stack(
              children: [
                AnimatedOpacity(
                  opacity: this.context.repositories().quizRepository().answerWrongAlert ? 1 : 0,
                  duration: Duration(milliseconds: 250),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          this.context.repositories().quizRepository().tryAgain();
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                            top: 8,
                            bottom: 8,
                            left: 16,
                            right: 16,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.all(
                              Radius.circular(32),
                            ),
                          ),
                          child: Text(
                            'TRY AGAIN',
                            style: TextStyle(
                              fontSize: p,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedOpacity(
                  opacity: this.context.repositories().quizRepository().answerWrongAlert ? 0 : 1,
                  duration: Duration(milliseconds: 250),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          this.context.repositories().quizRepository().resetChoice();
                        },
                        child: Container(
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  right: 16,
                                ),
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColorDark,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.code,
                                  color: Colors.white,
                                  size: 32,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: colorGrayDark,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.refresh,
                                  color: Colors.white,
                                  size: 32,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (this.parentPageRepository.currentPage ==
                              this.parentPageRepository.pageSize -
                                  1) {
                            await Future(() {
                              this.onNext();
                            });
                            if (!this.context.repositories().quizRepository().answerWrongAlert) {
                              this.onSuccess();
                            }
                          } else {
                            if (this.context.repositories().quizRepository().canAnswer) {
                              this.onNext();
                            }
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(
                                !this.context.repositories().quizRepository().canAnswer ? 0.25 : 1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.arrow_right,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
