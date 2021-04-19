import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_learning_x/models/module_model.dart';
import 'package:o_learning_x/models/sub_module_model.dart';
import 'package:o_learning_x/styles/colors.dart';
import 'package:o_learning_x/styles/fonts.dart';

class SubjectQuizItem extends StatelessWidget {
  final title;
  final List<ModuleModel> items;
  final Function(String id, List<SubModuleModel> quizItems) onClick;

  SubjectQuizItem({
    required this.title,
    required this.items,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(
            top: 8,
            bottom: 8,
            left: 16,
            right: 16,
          ),
          child: Text(
            this.title ?? '',
            style: TextStyle(
              fontSize: p,
              color: Colors.black,
            ),
          ),
        ),
        ...List.generate(
          this.items.length,
          (index) {
            return GestureDetector(
              onTap: () {
                this.onClick(
                    this.items[index].Id, this.items[index].SubModules);
              },
              child: Container(
                color: index % 2 == 0 ? Colors.white : colorPrimaryLighter,
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: index == 0
                            ? Theme.of(context).primaryColorDark
                            : Theme.of(context).primaryColorLight,
                        shape: BoxShape.circle,
                      ),
                      child: index == 0
                          ? Icon(
                              Icons.play_arrow_rounded,
                              color: Colors.white,
                            )
                          : Text(
                              index.toString(),
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(
                          left: 16,
                          right: 16,
                        ),
                        child: Text(
                          this.items[index].Title,
                          style: TextStyle(
                            fontSize: p,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
