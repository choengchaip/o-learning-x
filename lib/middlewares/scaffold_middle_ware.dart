import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_learning_x/configs/config.dart';
import 'package:o_learning_x/cores/context.dart';

class ScaffoldMiddleWare extends StatefulWidget {
  final IContext context;
  final IConfig config;
  final Widget child;

  ScaffoldMiddleWare({
    required this.context,
    required this.config,
    required this.child,
  });

  @override
  State<StatefulWidget> createState() {
    return ScaffoldMiddleWareState();
  }
}

class ScaffoldMiddleWareState extends State<ScaffoldMiddleWare> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
    );
  }
}
