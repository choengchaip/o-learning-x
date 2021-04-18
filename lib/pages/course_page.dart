import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_learning_x/configs/config.dart';
import 'package:o_learning_x/cores/context.dart';
import 'package:o_learning_x/features/quiz_feature.dart';
import 'package:o_learning_x/middlewares/scaffold_middle_ware.dart';
import 'package:o_learning_x/styles/colors.dart';
import 'package:o_learning_x/styles/fonts.dart';
import 'package:o_learning_x/widgets/commons/loading_stack.dart';
import 'package:o_learning_x/widgets/courses/course_section.dart';
import 'package:o_learning_x/widgets/courses/course_select.dart';
import 'package:rxdart/rxdart.dart';

class CoursePage extends StatefulWidget {
  final IContext context;
  final IConfig config;

  CoursePage({
    required this.context,
    required this.config,
  });

  @override
  State<StatefulWidget> createState() {
    return CoursePageState();
  }
}

class CoursePageState extends State<CoursePage> {
  late bool courseExpand;
  late StreamController<bool> courseExpandSC;
  late double transparentBg;
  late double oldTransparentBg;
  late StreamController<double> transparentBgSC;

  @override
  void initState() {
    super.initState();

    this.courseExpand = false;
    this.courseExpandSC = StreamController<bool>();
    this.courseExpandSC.add(this.courseExpand);

    this.transparentBg = 0;
    this.oldTransparentBg = 0;
    this.transparentBgSC = BehaviorSubject<double>();
    this.transparentBgSC.add(this.transparentBg);

    getMyCourse();
  }

  Future<void> getMyCourse() async {
    await widget.context.repositories().myCourseRepository().fetch();

    if (widget.context.repositories().myCourseRepository().items.length > 0) {
      await widget.context
          .repositories()
          .myCourseRepository()
          .get(widget.context.repositories().myCourseRepository().items[0].Id);

      widget.context.repositories().authenticationRepository().setCourseId(
          widget.context.repositories().myCourseRepository().items[0].Id);
      widget.context.repositories().authenticationRepository().setCourseName(
          widget.context.repositories().myCourseRepository().items[0].Title);

      this.courseExpand = !this.courseExpand;
      this.courseExpandSC.add(this.courseExpand);
      this.courseExpand = !this.courseExpand;
      this.courseExpandSC.add(this.courseExpand);
    }
  }

  @override
  void dispose() {
    this.courseExpandSC.close();
    this.transparentBgSC.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LoadingStack(
        isLoadingSCs: [
          widget.context.repositories().myCourseRepository().isLoadingSC,
        ],
        children: () => [
          StreamBuilder(
            stream: this.transparentBgSC.stream,
            builder: (context, snapshot) {
              return AnimatedOpacity(
                opacity: this.courseExpand ? 0.5 : 1,
                duration: Duration(milliseconds: 250),
                child: IgnorePointer(
                  ignoring: this.courseExpand,
                  child: Container(
                    color: Colors.white,
                    child: NotificationListener<ScrollUpdateNotification>(
                      onNotification: (n) {
                        double transparent = n.metrics.pixels / 200;
                        if (transparent > 1) {
                          transparent = 1;
                        }
                        if (transparent <= 0) {
                          transparent = 0;
                        }
                        if ((transparent == 1 && this.transparentBg != 1) ||
                            (transparent == 0)) {
                          this.transparentBg = transparent;
                          this.transparentBgSC.add(this.transparentBg);
                        }

                        return true;
                      },
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: widget.context
                                .repositories()
                                .myCourseRepository()
                                .data
                                ?.Modules
                                .length ??
                            0,
                        itemBuilder: (context, index) {
                          if (widget.context
                                  .repositories()
                                  .myCourseRepository()
                                  .data ==
                              null) {
                            return Container();
                          }

                          if (index == 0) {
                            return CourseSection(
                              context: widget.context,
                              config: widget.config,
                              topWidget: Container(
                                margin: EdgeInsets.only(bottom: 20),
                                height: 350,
                                width: MediaQuery.of(context).size.width,
                                child: Image.asset(
                                  'lib/statics/course_background.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              module: widget.context
                                  .repositories()
                                  .myCourseRepository()
                                  .data!
                                  .Modules
                                  .elementAt(0),
                              onClick: (id) async {
                                await widget.context
                                    .repositories()
                                    .quizRepository()
                                    .get(id);
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
                              },
                            );
                          }

                          return CourseSection(
                            context: widget.context,
                            config: widget.config,
                            module: widget.context
                                .repositories()
                                .myCourseRepository()
                                .data!
                                .Modules
                                .elementAt(index),
                            onClick: (id) async {
                              await widget.context
                                  .repositories()
                                  .quizRepository()
                                  .get(id);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          StreamBuilder(
            stream: this.courseExpandSC.stream,
            builder: (context, snapshot) {
              return CourseSelect(
                context: widget.context,
                config: widget.config,
                isExpand: this.courseExpand,
                items: widget.context.repositories().myCourseRepository().items,
                onChanged: (id, name) async {
                  this.courseExpand = !this.courseExpand;
                  this.courseExpandSC.add(this.courseExpand);

                  await widget.context
                      .repositories()
                      .myCourseRepository()
                      .get(id);

                  widget.context
                      .repositories()
                      .authenticationRepository()
                      .setCourseId(id);
                  widget.context
                      .repositories()
                      .authenticationRepository()
                      .setCourseName(name);
                },
              );
            },
          ),
          StreamBuilder<double>(
            stream: this.transparentBgSC.stream,
            builder: (BuildContext context, snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }

              return AnimatedContainer(
                duration: Duration(milliseconds: 250),
                color: colorPrimaryLight
                    .withOpacity(this.courseExpand ? 1 : snapshot.data!),
                height: 50 + MediaQuery.of(context).padding.top + 16,
                padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: MediaQuery.of(context).padding.top + 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.context
                                .repositories()
                                .myCourseRepository()
                                .items
                                .length ==
                            0
                        ? Container()
                        : GestureDetector(
                            onTap: () {
                              this.courseExpand = !this.courseExpand;
                              this.courseExpandSC.add(this.courseExpand);
                              if (this.courseExpand) {
                                this.transparentBgSC.add(1);
                              } else {
                                this.transparentBgSC.add(this.oldTransparentBg);
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: colorPrimaryLight,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(32),
                                ),
                              ),
                              padding: EdgeInsets.only(
                                  top: 6, bottom: 6, left: 12, right: 4),
                              child: Row(
                                children: [
                                  Container(
                                    child: Text(
                                      widget.context
                                          .repositories()
                                          .authenticationRepository()
                                          .currentCourseName,
                                      style: TextStyle(
                                        fontSize: p,
                                        fontWeight: fontWeightBold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Stack(
                                      children: [
                                        AnimatedOpacity(
                                          opacity: this.courseExpand ? 1 : 0,
                                          duration: Duration(milliseconds: 250),
                                          child: Container(
                                            child: Icon(
                                              Icons.keyboard_arrow_up,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        AnimatedOpacity(
                                          opacity: this.courseExpand ? 0 : 1,
                                          duration: Duration(milliseconds: 250),
                                          child: Container(
                                            child: Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    Container(
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                top: 4, bottom: 4, left: 6, right: 8),
                            margin: EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              color: colorPrimaryLight,
                              borderRadius: BorderRadius.all(
                                Radius.circular(32),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 2),
                                  child: Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 4),
                                  child: Text(
                                    widget.context
                                        .repositories()
                                        .authenticationRepository()
                                        .star
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: p,
                                      fontWeight: fontWeightBold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                top: 4, bottom: 4, left: 6, right: 8),
                            decoration: BoxDecoration(
                              color: colorPrimaryLight,
                              borderRadius: BorderRadius.all(
                                Radius.circular(32),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 2),
                                  child: Icon(
                                    Icons.leaderboard,
                                    color: Colors.greenAccent,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 4),
                                  child: Text(
                                    widget.context
                                        .repositories()
                                        .authenticationRepository()
                                        .progress
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: p,
                                      fontWeight: fontWeightBold,
                                      color: Colors.white,
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
            },
          ),
        ],
      ),
    );
  }
}
