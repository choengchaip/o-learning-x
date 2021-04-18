import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_learning_x/configs/config.dart';
import 'package:o_learning_x/cores/context.dart';
import 'package:o_learning_x/models/module_model.dart';
import 'package:o_learning_x/styles/colors.dart';
import 'package:o_learning_x/styles/fonts.dart';
import 'package:o_learning_x/widgets/courses/course_section_item.dart';

class CourseSection extends StatefulWidget {
  final IContext context;
  final IConfig config;
  final ModuleModel module;
  final Function(String id) onClick;
  Widget? topWidget;

  CourseSection({
    required this.context,
    required this.config,
    required this.module,
    required this.onClick,
    this.topWidget,
  }) {
    if (this.topWidget == null) {
      this.topWidget = Container();
    }
  }

  @override
  State<StatefulWidget> createState() {
    return CourseSectionState();
  }
}

class CourseSectionState extends State<CourseSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorGrayLighter,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 32),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                if (widget.topWidget != null) widget.topWidget!,
                Container(
                  margin: EdgeInsets.only(bottom: 14,),
                  height: 10,
                  color: Colors.white,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(32),
                    ),
                  ),
                  padding:
                      EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
                  child: Text(
                    widget.module.Title,
                    style: TextStyle(
                      fontSize: p,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: List.generate(
              widget.module.SubModules.length,
              (index) {
                return CourseSectionItem(
                  context: widget.context,
                  config: widget.config,
                  id: widget.module.SubModules[index].Id,
                  title: widget.module.SubModules[index].Title,
                  icon: Icons.ac_unit,
                  // icon: this.course.chapters[index].icon,
                  canLearn: true,
                  isPassed: true,
                  progress: (widget.module.SubModules[index].Current) > (widget.module.SubModules[index].Current)
                      ? (widget.module.SubModules[index].Max)
                      : (widget.module.SubModules[index].Current),
                  max: (widget.module.SubModules[index].Max),
                  onClick: widget.onClick,
                );
              },
            ),
          ),
          Container(
            height: 32,
          )
        ],
      ),
    );
  }
}
