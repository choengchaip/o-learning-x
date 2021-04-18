import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_learning_x/models/course_model.dart';
import 'package:o_learning_x/styles/fonts.dart';

import 'category_recommend_item.dart';

class CategoryRecommend extends StatelessWidget {
  final String title;
  final List<CourseModel> items;
  final Function(String id)? onClick;

  CategoryRecommend({
    required this.title,
    required this.items,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        bottom: 16,
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(
              top: 16,
              bottom: 16,
              left: 16,
              right: 16,
            ),
            child: Text(
              this.title,
              style: TextStyle(
                fontSize: p,
                fontWeight: fontWeightBold,
              ),
            ),
          ),
          Container(
            height: 125,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: 16, right: 16),
              itemCount: this.items.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    this.onClick?.call(this.items[index].Id);
                  },
                  child: CategoriesListRecommendItem(
                    index: index,
                    title: this.items[index].Title,
                    image: this.items[index].Image,
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
