import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_learning_x/styles/colors.dart';

class RadioButton extends StatelessWidget {
  final bool active;
  final Function? onClick;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  RadioButton({
    required this.active,
    this.onClick,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        this.onClick?.call();
      },
      child: Container(
        padding: this.padding,
        margin: this.margin,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorPrimary,
              ),
              width: 25,
              height: 25,
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: this.active ? Colors.white : colorPrimary,
              ),
              width: 10,
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
