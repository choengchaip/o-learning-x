import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_learning_x/configs/config.dart';
import 'package:o_learning_x/cores/context.dart';
import 'package:o_learning_x/models/module_model.dart';
import 'package:o_learning_x/styles/colors.dart';
import 'package:o_learning_x/styles/fonts.dart';

class CourseSection extends StatefulWidget {
  final IContext context;
  final IConfig config;
  final ModuleModel module;
  final Function(String id) onClick;
  late final Widget? topWidget;

  CourseSection({
    required this.context,
    required this.config,
    required this.module,
    required this.onClick,
    this.topWidget,
  }) {
    this.topWidget = this.topWidget ?? Container();
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
      padding: EdgeInsets.only(
        top: 32,
        bottom: 32,
      ),
      color: colorGrayLight,
      child: Column(
        children: [
          Container(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
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
              widget.module.SubModules.length ?? 0,
              (index) {
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
