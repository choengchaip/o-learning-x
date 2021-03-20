import 'package:flutter/cupertino.dart';
import 'package:o_learning_x/configs/config.dart';
import 'package:o_learning_x/cores/context.dart';

class AccountPage extends StatefulWidget {
  final IContext context;
  final IConfig config;

  AccountPage({
    required this.context,
    required this.config,
  });

  @override
  State<StatefulWidget> createState() {
    return AccountPageState();
  }
}

class AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
