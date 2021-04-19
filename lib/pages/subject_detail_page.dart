import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_learning_x/configs/config.dart';
import 'package:o_learning_x/cores/context.dart';
import 'package:o_learning_x/features/quiz_feature.dart';
import 'package:o_learning_x/middlewares/scaffold_middle_ware.dart';
import 'package:o_learning_x/models/sub_module_model.dart';
import 'package:o_learning_x/widgets/commons/cached_image.dart';
import 'package:o_learning_x/widgets/commons/header_back_button_center.dart';
import 'package:o_learning_x/widgets/commons/loading_stack.dart';
import 'package:o_learning_x/widgets/subjects/subject_quiz_item.dart';

class SubjectDetailPage extends StatefulWidget {
  final IContext context;
  final IConfig config;

  SubjectDetailPage({
    required this.context,
    required this.config,
  });

  @override
  State<StatefulWidget> createState() {
    return _SubjectDetailPageState();
  }
}

class _SubjectDetailPageState extends State<SubjectDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: LoadingStack(
        isLoadingSCs: [
          widget.context.repositories().myCourseRepository().isLoadingSC,
        ],
        children: () => [
          Container(
            child: Column(
              children: [
                HeaderBackButtonCenter(
                  headerTitle: widget.context
                          .repositories()
                          .myCourseRepository()
                          .data
                          ?.Title ??
                      "",
                  backTitle: 'Back',
                  onBack: () {
                    Navigator.of(context).pop();
                  },
                ),
                Expanded(
                  child: Container(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        CachedImage(
                          height: 250,
                          image: widget.context
                                  .repositories()
                                  .myCourseRepository()
                                  .data
                                  ?.Image ??
                              "",
                        ),
                        SubjectQuizItem(
                          title: widget.context
                                  .repositories()
                                  .myCourseRepository()
                                  .data
                                  ?.Description ??
                              "",
                          items: widget.context
                                  .repositories()
                                  .myCourseRepository()
                                  .data
                                  ?.Modules ??
                              [],
                          onClick: (String id,
                              List<SubModuleModel> subModules) async {
                            await widget.context
                                .repositories()
                                .quizRepository()
                                .get("", params: {
                              "sub_modules": subModules,
                            });
                            if (!widget.context
                                .repositories()
                                .quizRepository()
                                .isError) {
                              await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ScaffoldMiddleWare(
                                      context: widget.context,
                                      config: widget.config,
                                      child: QuizFeature(
                                        context: widget.context,
                                        config: widget.config,
                                      ),
                                    );
                                  },
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
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
