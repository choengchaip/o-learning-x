import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_learning_x/styles/fonts.dart';
import 'package:o_learning_x/utils/string_helper.dart';
import 'package:o_learning_x/widgets/commons/cached_image.dart';

class CategoriesListRecommendItem extends StatelessWidget {
  final int index;
  final String image;
  final String title;

  CategoriesListRecommendItem({
    required this.index,
    required this.image,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      width: 140,
      child: Column(
        children: [
          Expanded(
            child: Container(
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
                child: CachedImage(
                  errorImage: 'lib/statics/default/courses/course_${this.index % 4}.jpg',
                  image: this.image,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: 8,
              bottom: 8,
            ),
            child: Text(
              StringHelper.capitalize(this.title),
              style: TextStyle(
                fontSize: s,
                fontWeight: fontWeightBold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
