import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_learning_x/configs/config.dart';
import 'package:o_learning_x/cores/context.dart';
import 'package:o_learning_x/models/course_model.dart';
import 'package:o_learning_x/widgets/courses/course_item.dart';

class CourseSelect extends StatefulWidget {
  final IContext context;
  final IConfig config;
  final bool isExpand;
  final List<CourseModel> items;
  final Function(String id, String name) onChanged;

  CourseSelect({
    required this.context,
    required this.config,
    required this.isExpand,
    required this.items,
    required this.onChanged,
  });

  @override
  State<StatefulWidget> createState() {
    return CourseSelectState();
  }
}

class CourseSelectState extends State<CourseSelect> {
  late StreamController<String> selectedCourseSC;
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();

    this.selectedCourseSC = StreamController<String>();
    this.scrollController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();

    this.selectedCourseSC.close();
    this.scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: selectedCourseSC.stream,
      builder: (BuildContext context, snapshot) {
        return AnimatedPositioned(
          duration: Duration(milliseconds: 250),
          curve: Curves.ease,
          top: widget.isExpand
              ? 50 + MediaQuery.of(context).padding.top + 16
              : -(MediaQuery.of(context).size.width * 0.85) -
                  (MediaQuery.of(context).padding.top),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width * 0.85,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 1),
                    color: Colors.black12,
                    blurRadius: 3,
                    spreadRadius: 3),
              ],
            ),
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              controller: this.scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.items.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    this.scrollController.animateTo(
                        (MediaQuery.of(context).size.width * 0.75) * index,
                        duration: Duration(milliseconds: 250),
                        curve: Curves.ease);
                    this.selectedCourseSC.add(widget.items[index].Id);
                    widget.onChanged(
                        widget.items[index].Id, widget.items[index].Title);
                  },
                  child: CourseItem(
                    context: widget.context,
                    config: widget.config,
                    index: index,
                    image: widget.items[index].Image,
                    title: widget.items[index].Title,
                    description: widget.items[index].Description,
                    progress: widget.items[index].Current,
                    isActive: snapshot.data == widget.items[index].Id,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
