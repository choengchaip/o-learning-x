import  'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_learning_x/configs/config.dart';
import 'package:o_learning_x/cores/context.dart';
import 'package:o_learning_x/styles/colors.dart';
import 'package:o_learning_x/styles/fonts.dart';

class WelcomeInformation extends StatefulWidget {
  final IContext context;
  final IConfig config;
  final String logoImage;
  final String title;
  final String description;

  WelcomeInformation({
    required this.context,
    required this.config,
    required this.logoImage,
    required this.title,
    required this.description,
  });

  @override
  WelcomeInformationState createState() {
    return WelcomeInformationState();
  }
}

class WelcomeInformationState extends State<WelcomeInformation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 16, bottom: 16, left: 46, right: 64),
            height: 250,
            child: Image.asset(widget.logoImage),
            decoration: BoxDecoration(shape: BoxShape.circle),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Text(
              widget.title,
              style: TextStyle(
                fontSize: h3,
                fontWeight: fontWeightBold,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 32, left: 16, right: 16),
            child: Text(
              widget.description,
              style: TextStyle(
                fontSize: p,
                color: colorGray,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
