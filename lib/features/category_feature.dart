import 'package:flutter/cupertino.dart';
import 'package:o_learning_x/configs/config.dart';
import 'package:o_learning_x/cores/context.dart';
import 'package:o_learning_x/pages/base_page.dart';
import 'package:o_learning_x/pages/category_page.dart';
import 'package:o_learning_x/pages/chapter_page.dart';
import 'package:o_learning_x/repositories/page_repository.dart';

class CategoryFeature extends StatefulWidget {
  final IContext context;
  final IConfig config;

  CategoryFeature({
    required this.context,
    required this.config,
  });

  @override
  State<StatefulWidget> createState() {
    return _CategoryFeatureState();
  }
}

class _CategoryFeatureState extends State<CategoryFeature> {
  late PageRepository pageRepository;

  @override
  void initState() {
    this.pageRepository = PageRepository();
    this.pageRepository.initial();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: Container(
              child: BasePage(
                pageRepository: this.pageRepository,
                widgets: [
                  CategoryPage(
                    context: widget.context,
                    config: widget.config,
                    parentPageRepository: this.pageRepository,
                  ),
                  ChapterPage(
                    context: widget.context,
                    config: widget.config,
                    parentPageRepository: this.pageRepository,
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
