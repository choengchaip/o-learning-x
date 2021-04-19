import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_learning_x/styles/fonts.dart';

class HeaderBackButtonCenter extends StatelessWidget {
  final String headerTitle;
  final String backTitle;
  final Function? onBack;

  HeaderBackButtonCenter({
    required this.headerTitle,
    required this.backTitle,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 8 + MediaQuery.of(context).padding.top,
        bottom: 8,
        left: 16,
        right: 16,
      ),
      color: Theme.of(context).primaryColorLight,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            child: Text(
              this.headerTitle,
              style: TextStyle(
                color: Colors.white,
                fontSize: p,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              this.onBack?.call();
            },
            child: Container(
              padding: EdgeInsets.only(top: 2.5),
              child: Row(
                children: [
                  Container(
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: h5,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    child: Text(
                      this.backTitle,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: s,
                        fontWeight: FontWeight.bold,
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
