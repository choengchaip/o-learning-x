import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_learning_x/configs/config.dart';
import 'package:o_learning_x/cores/context.dart';
import 'package:o_learning_x/middlewares/scaffold_middle_ware.dart';
import 'package:o_learning_x/pages/subject_detail_page.dart';
import 'package:o_learning_x/repositories/page_repository.dart';
import 'package:o_learning_x/styles/colors.dart';
import 'package:o_learning_x/widgets/categories/category_continue_learning.dart';
import 'package:o_learning_x/widgets/categories/category_recommend.dart';
import 'package:o_learning_x/widgets/categories/category_search.dart';
import 'package:o_learning_x/widgets/commons/loading_stack.dart';

class CategoryPage extends StatefulWidget {
  final IContext context;
  final IConfig config;
  final PageRepository parentPageRepository;

  CategoryPage({
    required this.context,
    required this.config,
    required this.parentPageRepository,
  });

  @override
  State<StatefulWidget> createState() {
    return CategoryPageState();
  }
}

class CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    super.initState();

    widget.context.repositories().courseRepository().fetch(params: {
      "category_id": "none",
    });
    widget.context.repositories().myCourseRepository().fetch();
    widget.context.repositories().categoryRepository().fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LoadingStack(
        isLoadingSCs: [
          widget.context.repositories().courseRepository().isLoadingSC,
          widget.context.repositories().myCourseRepository().isLoadingSC,
          widget.context.repositories().categoryRepository().isLoadingSC,
        ],
        children: () => [
          AnimatedContainer(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
            ),
            duration: Duration(milliseconds: 250),
            color: colorGrayLighter,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                CategoryContinueLearning(
                  context: widget.context,
                  config: widget.config,
                  title: widget.context.localeRepository().getString("continue_learning"),
                  items:
                      widget.context.repositories().myCourseRepository().items,
                  onClick: (String id) async {
                    await widget.context
                        .repositories()
                        .myCourseRepository()
                        .get(id);
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ScaffoldMiddleWare(
                          context: widget.context,
                          config: widget.config,
                          child: SubjectDetailPage(
                            context: widget.context,
                            config: widget.config,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                CategoryRecommend(
                  title: widget.context.localeRepository().getString("recommend_course"),
                  items: widget.context.repositories().courseRepository().items,
                  onClick: (String id) async {
                    await widget.context
                        .repositories()
                        .myCourseRepository()
                        .get(id);
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ScaffoldMiddleWare(
                          context: widget.context,
                          config: widget.config,
                          child: SubjectDetailPage(
                            context: widget.context,
                            config: widget.config,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                CategorySearch(
                  title: widget.context.localeRepository().getString("browse_categories"),
                  localeRepository: widget.context.localeRepository(),
                  items:
                      widget.context.repositories().categoryRepository().items,
                  onClick: (String id, String name) async {
                    await widget.context
                        .repositories()
                        .subjectRepository()
                        .setCategoryName(name);
                    await widget.context
                        .repositories()
                        .categoryRepository()
                        .fetch(params: {
                      "category_id": "none",
                    });
                    widget.parentPageRepository.nextPage();
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
