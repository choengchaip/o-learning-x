import 'package:flutter/cupertino.dart';
import 'package:o_learning_x/configs/config.dart';
import 'package:o_learning_x/cores/context.dart';

class LeaderBoardPage extends StatefulWidget {
  final IContext context;
  final IConfig config;

  LeaderBoardPage({
    required this.context,
    required this.config,
  });

  @override
  State<StatefulWidget> createState() {
    return LeaderBoardPageState();
  }
}

class LeaderBoardPageState extends State<LeaderBoardPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
