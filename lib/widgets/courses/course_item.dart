import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_learning_x/configs/config.dart';
import 'package:o_learning_x/cores/context.dart';
import 'package:o_learning_x/models/course_model.dart';
import 'package:o_learning_x/styles/colors.dart';
import 'package:o_learning_x/styles/fonts.dart';
import 'package:o_learning_x/widgets/commons/cached_image.dart';

class CourseItem extends StatefulWidget {
  final IContext context;
  final IConfig config;
  final int index;
  final String image;
  final String title;
  final String description;
  final bool isActive;
  final EdgeInsets? margin;
  final int? progress;

  CourseItem({
    required this.context,
    required this.config,
    required this.index,
    required this.image,
    required this.title,
    required this.description,
    required this.isActive,
    this.margin,
    this.progress,
  });

  @override
  State<StatefulWidget> createState() {
    return CourseItemState();
  }
}

class CourseItemState extends State<CourseItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 8, right: 16),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.75,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              widget.isActive
                  ? BoxShadow(
                      color: Theme.of(context).primaryColor,
                      blurRadius: 0,
                      spreadRadius: 3)
                  : BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, 1),
                      blurRadius: 6,
                      spreadRadius: 1)
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Column(
              children: [
                Flexible(
                  flex: 4,
                  child: CachedImage(
                    image: widget.image,
                  ),
                ),
                Flexible(
                  flex: 5,
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 8),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.title,
                            style: TextStyle(
                              color: colorGrayDark,
                              fontSize: p,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              widget.description,
                              style: TextStyle(
                                color: colorGray,
                                fontSize: s2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        widget.progress != null
                            ? Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '${widget.progress}% (appLocale)',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: s,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            : Container(),
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
