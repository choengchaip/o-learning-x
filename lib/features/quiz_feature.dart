import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_learning_x/configs/config.dart';
import 'package:o_learning_x/cores/context.dart';
import 'package:o_learning_x/features/score_summary_feature.dart';
import 'package:o_learning_x/middlewares/scaffold_middle_ware.dart';
import 'package:o_learning_x/pages/base_page.dart';
import 'package:o_learning_x/repositories/page_repository.dart';
import 'package:o_learning_x/widgets/commons/loading_stack.dart';
import 'package:o_learning_x/widgets/quizs/quiz_bottom.dart';
import 'package:o_learning_x/widgets/quizs/quiz_item.dart';
import 'package:o_learning_x/widgets/quizs/quiz_navbar.dart';
import 'package:o_learning_x/widgets/quizs/quiz_progress.dart';

class QuizFeature extends StatefulWidget {
  final IContext context;
  final IConfig config;

  QuizFeature({
    required this.context,
    required this.config,
  });

  @override
  State<StatefulWidget> createState() {
    return _QuizFeature();
  }
}

class _QuizFeature extends State<QuizFeature> {
  late PageRepository pageRepository;
  late StreamController<bool> positionController;
  late StreamController<double> progressController;
  late bool isHasRun;
  late int questionIndex;

  @override
  void initState() {
    this.pageRepository = PageRepository();
    this.pageRepository.initial();
    this.pageRepository.jumpTo(0);

    this.positionController = StreamController<bool>();
    this.progressController = StreamController<double>();
    this.positionController.add(false);
    this.progressController.add(0);
    this.isHasRun = false;
    this.questionIndex = 0;

    super.initState();
  }

  @override
  void dispose() {
    this.positionController.close();
    this.progressController.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LoadingStack(
        isLoadingSCs: [
          widget.context.repositories().quizRepository().isLoadingSC,
        ],
        children: () => [
          StreamBuilder<bool>(
            stream: positionController.stream,
            builder: (BuildContext context, snapshot) {
              if (!snapshot.hasData) {
                return Container();
              } else {
                if (!this.isHasRun) {
                  this.isHasRun = true;
                  this.positionController.add(true);
                }
              }

              return AnimatedPositioned(
                top: snapshot.data! ? 0 : MediaQuery.of(context).size.height,
                duration: Duration(milliseconds: 250),
                curve: Curves.ease,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: IgnorePointer(
                  ignoring:
                      widget.context.repositories().quizRepository().isLoading,
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        QuizNavBar(
                          onClose: () async {
                            widget.context
                                .repositories()
                                .quizRepository()
                                .answerWrongAlert = false;
                            widget.context
                                .repositories()
                                .quizRepository()
                                .resetAnswer();
                            this.positionController.add(false);
                            await Future.delayed(Duration(milliseconds: 250),
                                () {
                              widget.context
                                  .repositories()
                                  .quizRepository()
                                  .hideQuizFeature();
                              widget.context
                                  .repositories()
                                  .quizRepository()
                                  .disposeChoices();
                            });

                            Navigator.of(context).pop();
                          },
                        ),
                        StreamBuilder<double>(
                          stream: progressController.stream,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Container();
                            }

                            if (this.pageRepository.currentPage == 0) {
                              this.progressController.add(
                                  (MediaQuery.of(context).size.width * 1) /
                                      (widget.context
                                              .repositories()
                                              .quizRepository()
                                              .data
                                              ?.TotalQuestion ??
                                          1));
                            }

                            return QuizProgress(
                              progress: snapshot.data ?? 0,
                            );
                          },
                        ),
                        Expanded(
                          child: Container(
                            child: BasePage(
                              pageRepository: this.pageRepository,
                              widgets: List.generate(
                                widget.context
                                        .repositories()
                                        .quizRepository()
                                        .data
                                        ?.Questions
                                        .length ??
                                    0,
                                (index) {
                                  if (this.questionIndex == index) {
                                    widget.context
                                            .repositories()
                                            .quizRepository()
                                            .currentQuestionId =
                                        widget.context
                                            .repositories()
                                            .quizRepository()
                                            .data!
                                            .Questions[index]
                                            .Id;
                                    widget.context
                                        .repositories()
                                        .quizRepository()
                                        .forceValueNotify();
                                  }

                                  return QuizItem(
                                    context: widget.context,
                                    config: widget.config,
                                    questionItem: widget.context
                                        .repositories()
                                        .quizRepository()
                                        .data!
                                        .Questions[index],
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        QuizBottom(
                          context: widget.context,
                          config: widget.config,
                          parentPageRepository: this.pageRepository,
                          onSuccess: () async {
                            widget.context.repositories().quizRepository();
                            widget.context
                                .repositories()
                                .quizRepository()
                                .answerWrongAlert = false;
                            await widget.context
                                .repositories()
                                .quizRepository()
                                .submitAnswer();
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => ScaffoldMiddleWare(
                                  context: widget.context,
                                  config: widget.config,
                                  child: ScoreSummaryFeature(
                                    context: widget.context,
                                    config: widget.config,
                                  ),
                                ),
                              ),
                            );

                            this.positionController.add(false);
                            widget.context
                                .repositories()
                                .quizRepository()
                                .hideQuizFeature();
                            widget.context
                                .repositories()
                                .quizRepository()
                                .disposeChoices();
                            widget.context
                                .repositories()
                                .quizRepository()
                                .resetAnswer();
                          },
                          onNext: () {
                            widget.context
                                .repositories()
                                .quizRepository()
                                .answerQuestion();

                            if (!widget.context
                                .repositories()
                                .quizRepository()
                                .answerWrongAlert) {
                              widget.context
                                  .repositories()
                                  .quizRepository()
                                  .currentChoiceId = '';
                              widget.context
                                  .repositories()
                                  .quizRepository()
                                  .currentQuestionId = '';
                              this.progressController.add(num.parse(
                                      ((MediaQuery.of(context).size.width *
                                                  (this
                                                          .pageRepository
                                                          .currentPage +
                                                      1)) /
                                              (widget.context
                                                      .repositories()
                                                      .quizRepository()
                                                      .data
                                                      ?.TotalQuestion ??
                                                  1))
                                          .toStringAsFixed(8))
                                  .toDouble());
                              this.pageRepository.nextPage();
                              this.questionIndex++;
                            }

                            widget.context
                                .repositories()
                                .quizRepository()
                                .forceValueNotify();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
