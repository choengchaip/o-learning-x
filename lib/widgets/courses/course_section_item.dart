import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_learning_x/configs/config.dart';
import 'package:o_learning_x/cores/context.dart';
import 'package:o_learning_x/styles/colors.dart';
import 'package:o_learning_x/styles/fonts.dart';

class CourseSectionItem extends StatefulWidget {
  final IContext context;
  final IConfig config;
  final String id;
  final String title;
  final IconData icon;
  final bool canLearn;
  final bool isPassed;
  final int progress;
  final int max;
  final Function(String id) onClick;

  CourseSectionItem({
    required this.context,
    required this.config,
    required this.id,
    required this.title,
    required this.icon,
    required this.canLearn,
    required this.isPassed,
    required this.progress,
    required this.max,
    required this.onClick,
  });

  @override
  State<StatefulWidget> createState() {
    return CourseSectionItemState();
  }
}

class CourseSectionItemState extends State<CourseSectionItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.canLearn) {
          widget.onClick(widget.id);
        } else {
          Flushbar(
            flushbarPosition: FlushbarPosition.TOP,
            title: 'This Skill is locked',
            message: 'Finish Level 1 of the previous Skill to unlock.',
            backgroundColor: colorPrimary,
            duration: Duration(seconds: 2),
          )..show(context);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(
                color: widget.canLearn ? Colors.black12 : Colors.transparent,
                offset: Offset(0, 3),
                blurRadius: 1,
                spreadRadius: 0),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black,
                    offset: Offset(0, 0),
                    blurRadius: 6,
                    spreadRadius: 6),
              ],
            ),
            width: (MediaQuery.of(context).size.width / 2) - 24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 8, left: 12, right: 12),
                  margin: EdgeInsets.only(bottom: 4),
                  child: Icon(
                    widget.icon,
                    size: h3,
                    color: widget.canLearn
                        ? colorPrimary
                        : Colors.black26,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 12, right: 12),
                  height: 50,
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      color: widget.canLearn ? Colors.black : Colors.black26,
                      fontSize: p,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Opacity(
                  opacity: widget.canLearn ? 1 : 0,
                  child: Container(
                    padding: EdgeInsets.only(bottom: 8, left: 12, right: 12),
                    child: Icon(
                      Icons.star,
                      size: h3,
                      color: widget.isPassed ? Colors.yellow : Colors.black12,
                    ),
                  ),
                ),
                Opacity(
                  opacity: widget.canLearn ? 1 : 0,
                  child: Container(
                    child: Row(
                      children: [
                        Flexible(
                          flex: widget.progress,
                          child: Container(
                            height: 8,
                            color: Colors.yellow,
                          ),
                        ),
                        Flexible(
                          flex: widget.max - widget.progress,
                          child: Container(
                            height: 8,
                            color: Colors.black12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
