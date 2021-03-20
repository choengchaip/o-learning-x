import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_learning_x/configs/config.dart';
import 'package:o_learning_x/cores/context.dart';

class GeneralMiddleWare extends StatefulWidget {
  final IContext context;
  final IConfig config;
  final Widget child;

  GeneralMiddleWare({
    required this.context,
    required this.config,
    required this.child,
  });

  @override
  State<StatefulWidget> createState() {
    return GeneralMiddleWareState();
  }
}

class GeneralMiddleWareState extends State<GeneralMiddleWare> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
