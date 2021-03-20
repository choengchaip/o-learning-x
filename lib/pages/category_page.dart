import 'package:flutter/cupertino.dart';
import 'package:o_learning_x/configs/config.dart';
import 'package:o_learning_x/cores/context.dart';

class CategoryPage extends StatefulWidget {
  final IContext context;
  final IConfig config;

  CategoryPage({
    required this.context,
    required this.config,
  });

  @override
  State<StatefulWidget> createState() {
    return CategoryPageState();
  }
}

class CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
