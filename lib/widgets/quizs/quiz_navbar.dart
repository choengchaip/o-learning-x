import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_learning_x/styles/colors.dart';

class QuizNavBar extends StatelessWidget {
  final Function onClose;

  QuizNavBar({
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 8,
        bottom: 8,
        left: 8,
        right: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              this.onClose();
            },
            child: Container(
              child: Icon(
                Icons.close,
                color: colorGray,
                size: 32,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
