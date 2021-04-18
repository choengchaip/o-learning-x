import 'package:flutter/cupertino.dart';
import 'package:o_learning_x/configs/config.dart';
import 'package:o_learning_x/cores/context.dart';
import 'package:o_learning_x/models/course_model.dart';
import 'package:o_learning_x/styles/fonts.dart';

import 'category_continue_learning_item.dart';

class CategoryContinueLearning extends StatefulWidget {
  final IContext context;
  final IConfig config;

  final String title;
  final List<CourseModel> items;
  final Function(String id)? onClick;

  CategoryContinueLearning({
    required this.context,
    required this.config,
    required this.title,
    required this.items,
    this.onClick,
  });

  @override
  State<StatefulWidget> createState() {
    return _CategoryContinueLearning();
  }
}

class _CategoryContinueLearning extends State<CategoryContinueLearning> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 16,
        bottom: 32,
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(bottom: 16, left: 16, right: 16),
            child: Text(
              widget.title,
              style: TextStyle(
                fontSize: p,
                fontWeight: fontWeightBold,
              ),
            ),
          ),
          Container(
            height: 193,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(
                top: 8,
                bottom: 8,
                left: 16,
                right: 16,
              ),
              itemCount: widget.items.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: (){
                    widget.onClick?.call(widget.items[index].Id);
                  },
                  child: CategoriesListContinueLearningItem(
                    index: index,
                    title: widget.items[index].Title,
                    image: widget.items[index].Image,
                    progress: widget.items[index].Current,
                    totalChoice: widget.items[index].Max,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
