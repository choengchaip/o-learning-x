import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_learning_x/models/course_model.dart';
import 'chapter_list_item.dart';

class ChapterList extends StatelessWidget {
  final List<CourseModel> items;
  final Function(String id) onClick;

  ChapterList({
    required this.items,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: this.items.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                this.onClick(this.items[index].Id);
              },
              child: ChapterListItem(
                id: this.items[index].Id,
                index: index,
                title: this.items[index].Title,
                description: this.items[index].Description,
                image: this.items[index].Image,
              ),
            );
          },
        ),
      ),
    );
  }
}
