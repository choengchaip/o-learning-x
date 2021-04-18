import 'package:flutter/cupertino.dart';
import 'package:o_learning_x/configs/config.dart';
import 'package:o_learning_x/cores/context.dart';
import 'package:o_learning_x/styles/colors.dart';
import 'package:o_learning_x/widgets/categories/category_continue_learning.dart';
import 'package:o_learning_x/widgets/categories/category_recommend.dart';
import 'package:o_learning_x/widgets/categories/category_search.dart';
import 'package:o_learning_x/widgets/commons/loading_stack.dart';

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
                  title: "continue_learning",
                  items: widget.context.repositories().myCourseRepository().items,
                  onClick: (String id) async {
                    // await subjectRepository.getCourseDetail(id);
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (_) => SubjectDetailPage()));
                  },
                ),
                CategoryRecommend(
                  title: "recommend_course",
                  items: widget.context.repositories().courseRepository().items,
                  onClick: (String id) async {
                    // await subjectRepository.getCourseDetail(id);
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (_) => SubjectDetailPage()));
                  },
                ),
                CategorySearch(
                  title: "browse_categories",
                  items: widget.context.repositories().categoryRepository().items,
                  onClick: (String id, String name) async {
                    // await subjectRepository.setCategoryName(name);
                    // await subjectRepository.getCategoryDetail(id);
                    // this.widgetSliderRepository.nextWidget();
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
