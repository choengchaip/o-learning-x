import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_learning_x/configs/config.dart';
import 'package:o_learning_x/cores/context.dart';
import 'package:o_learning_x/middlewares/scaffold_middle_ware.dart';
import 'package:o_learning_x/pages/subject_detail_page.dart';
import 'package:o_learning_x/repositories/page_repository.dart';
import 'package:o_learning_x/widgets/chapters/chapter_list.dart';
import 'package:o_learning_x/widgets/commons/header_back_button_center.dart';
import 'package:o_learning_x/widgets/commons/loading_stack.dart';

class ChapterPage extends StatefulWidget {
  final IContext context;
  final IConfig config;
  final PageRepository parentPageRepository;

  ChapterPage({
    required this.context,
    required this.config,
    required this.parentPageRepository,
  });

  @override
  State<StatefulWidget> createState() {
    return _ChapterPageState();
  }
}

class _ChapterPageState extends State<ChapterPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: LoadingStack(
        isLoadingSCs: [
          widget.context.repositories().courseRepository().isLoadingSC,
        ],
        children: () => [
          Container(
            child: Column(
              children: [
                HeaderBackButtonCenter(
                  headerTitle: widget.context
                      .repositories()
                      .subjectRepository()
                      .categoryName,
                  backTitle: "back",
                  onBack: () {
                    widget.parentPageRepository.prevPage();
                  },
                ),
                ChapterList(
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
              ],
            ),
          ),
        ],
      ),
    );

    // return Loading(
    //   isLoading: subjectRepository.status.isLoading,
    //   component: Container(
    //     child: Column(
    //       children: [
    //         HeaderBackButtonCenter(
    //           headerTitle: subjectRepository.categoryName,
    //           backTitle: 'Back',
    //           onBack: () {
    //             this.widgetSliderRepository.prevWidget();
    //           },
    //         ),
    //         ChapterListFeature(
    //           items: subjectRepository.categoryCourseItems,
    //           onClick: (String id) async {
    //             await subjectRepository.getCourseDetail(id);
    //             Navigator.of(context).push(
    //                 MaterialPageRoute(builder: (_) => SubjectDetailPage()));
    //           },
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
