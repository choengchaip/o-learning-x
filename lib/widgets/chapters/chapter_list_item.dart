import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:o_learning_x/styles/colors.dart';
import 'package:o_learning_x/styles/fonts.dart';
import 'package:o_learning_x/widgets/commons/cached_image.dart';

class ChapterListItem extends StatelessWidget {
  final String id;
  final int index;
  final String title;
  final String description;
  final String image;

  ChapterListItem({
    required this.id,
    required this.index,
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: colorGrayLighter,
          ),
        ),
      ),
      height: 110,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(6),
              ),
              child: CachedImage(
                errorImage:
                    'lib/statics/default/courses/course_${this.index % 4}.jpg',
                image: this.image,
                width: 100,
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      this.title,
                      style: TextStyle(
                        fontSize: h4,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        this.description,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: s,
                          color: colorGray,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
