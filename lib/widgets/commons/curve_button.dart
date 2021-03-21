import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_learning_x/styles/colors.dart';
import 'package:o_learning_x/styles/fonts.dart';

class CurveButton extends StatefulWidget {
  final void Function() onClick;
  final String title;
  final Color? backgroundColor;
  final Color? textColor;
  final EdgeInsets? margin;

  CurveButton({
    required this.onClick,
    required this.title,
    this.backgroundColor,
    this.textColor,
    this.margin,
  });

  @override
  State<StatefulWidget> createState() {
    return CurveButtonState();
  }
}

class CurveButtonState extends State<CurveButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClick,
      child: Container(
        margin: widget.margin,
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: widget.backgroundColor ?? colorPrimary,
        ),
        child: Text(
          widget.title,
          style: TextStyle(
            height: 1,
            fontSize: p,
            color: widget.textColor ?? Colors.white,
          ),
        ),
      ),
    );
  }
}
