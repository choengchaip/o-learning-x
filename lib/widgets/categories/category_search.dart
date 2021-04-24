import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_learning_x/models/category_model.dart';
import 'package:o_learning_x/repositories/locale_repository.dart';
import 'package:o_learning_x/styles/colors.dart';
import 'package:o_learning_x/styles/fonts.dart';

class CategorySearch extends StatelessWidget {
  final String title;
  final List<CategoryModel> items;
  final LocaleRepository localeRepository;
  final Function(String id, String name)? onClick;

  CategorySearch({
    required this.title,
    required this.items,
    required this.localeRepository,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    this.title,
                    style: TextStyle(
                      fontSize: p,
                      fontWeight: fontWeightBold,
                    ),
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 2),
                        child: Icon(
                          Icons.search,
                          color: colorPrimary,
                          size: h4,
                        ),
                      ),
                      GestureDetector(
                        onTap: (){

                        },
                        child: Container(
                          child: Text(
                            this.localeRepository.getString("search"),
                            style: TextStyle(
                              color: colorPrimary,
                              fontSize: p,
                              fontWeight: fontWeightBold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 12),
            child: Column(
              children: List.generate(
                this.items.length,
                    (int index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 12),
                    alignment: Alignment.centerLeft,
                    height: 50,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(6),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          this.onClick?.call(this.items[index].Id, this.items[index].Title);
                        },
                        child: Container(
                          color: colorSecondary,
                          child: Row(
                            children: [
                              AnimatedContainer(
                                duration: Duration(seconds: 2),
                                margin: EdgeInsets.only(right: 16),
                                width: 8,
                                color: Color((Random().nextDouble() * 0xFFFFFF)
                                    .toInt())
                                    .withOpacity(1.0),
                              ),
                              Expanded(
                                child: Container(
                                  child: Text(
                                    this.items[index].Title,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: s,
                                      fontWeight: fontWeightBold,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 14),
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  size: h5,
                                  color: Colors.white.withOpacity(0.5),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
