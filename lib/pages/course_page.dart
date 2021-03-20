import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_learning_x/configs/config.dart';
import 'package:o_learning_x/cores/context.dart';
import 'package:o_learning_x/widgets/commons/loading_stack.dart';
import 'package:o_learning_x/widgets/courses/course_section.dart';

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
  late double transparentBg;

  @override
  void initState() {
    super.initState();

    this.courseExpand = false;
    this.transparentBg = 0;

    widget.context.repositories().myCourseRepository().fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LoadingStack(
        isLoadingSCs: [
          widget.context.repositories().courseRepository().isLoadingSC,
        ],
        children: () => [
          AnimatedOpacity(
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
                    if (transparent <= 1) {
                      this.transparentBg = transparent;
                    }

                    return true;
                  },
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: 0,
                    itemBuilder: (context, index) {
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
                              .items[index]
                              .Modules[0],
                          onClick: (id) {},
                        );
                      }

                      return CourseSection(
                        context: widget.context,
                        config: widget.config,
                        module: widget.context
                            .repositories()
                            .myCourseRepository()
                            .items[index]
                            .Modules[index],
                        onClick: (id) {},
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
