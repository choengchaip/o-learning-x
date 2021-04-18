import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_learning_x/styles/colors.dart';
import 'package:o_learning_x/styles/fonts.dart';
import 'package:o_learning_x/widgets/commons/cached_image.dart';

class CategoriesListContinueLearningItem extends StatelessWidget {
  final int index;
  final String image;
  final String title;
  final int progress;
  final int totalChoice;

  CategoriesListContinueLearningItem({
    required this.index,
    required this.image,
    required this.title,
    required this.progress,
    required this.totalChoice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        boxShadow: [
          BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 2),
              blurRadius: 3,
              spreadRadius: 0),
        ],
      ),
      width: 140,
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        child: Column(
          children: [
            Flexible(
              flex: 11,
              child: CachedImage(
                image: this.image,
                errorImage: 'lib/statics/default/courses/course_${index % 5}.jpg',
              ),
            ),
            Flexible(
              flex: 4,
              child: Container(
                padding: EdgeInsets.only(left: 12, right: 12),
                alignment: Alignment.centerLeft,
                color: Colors.white,
                child: Text(
                  'COURSE ${this.progress}/${this.totalChoice}',
                  style: TextStyle(
                    fontSize: s2,
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 7,
              child: Container(
                padding: EdgeInsets.only(left: 12, right: 12),
                alignment: Alignment.topLeft,
                color: Colors.white,
                child: Text(
                  this.title,
                  style: TextStyle(
                    fontSize: p,
                    fontWeight: fontWeightBold,
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                color: Colors.white,
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                color: colorGrayLighter,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
