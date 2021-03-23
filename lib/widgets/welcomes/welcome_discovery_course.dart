import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_learning_x/configs/config.dart';
import 'package:o_learning_x/cores/constants.dart';
import 'package:o_learning_x/cores/context.dart';
import 'package:o_learning_x/repositories/page_repository.dart';
import 'package:o_learning_x/styles/colors.dart';
import 'package:o_learning_x/styles/fonts.dart';
import 'package:o_learning_x/widgets/commons/curve_button.dart';
import 'package:o_learning_x/widgets/commons/loading_stack.dart';
import 'package:o_learning_x/widgets/courses/course_item.dart';

class WelcomeDiscoveryCourse extends StatefulWidget {
  final IContext context;
  final IConfig config;
  final PageRepository parentPageRepository;
  final PageRepository rootPageRepository;

  WelcomeDiscoveryCourse({
    required this.context,
    required this.config,
    required this.parentPageRepository,
    required this.rootPageRepository,
  });

  @override
  State<StatefulWidget> createState() {
    return _WelcomeDiscoveryCourseState();
  }
}

class _WelcomeDiscoveryCourseState extends State<WelcomeDiscoveryCourse> {
  late PageRepository pageRepository;
  late ScrollController scrollController;
  late String selectedCourseId;

  @override
  void initState() {
    super.initState();

    this.pageRepository = PageRepository();
    this.pageRepository.initial();
    this.scrollController = ScrollController();
    this.selectedCourseId = "";

    widget.context
        .repositories()
        .courseRepository()
        .fetch(params: {"category_id": "none"}).then((_) {
      if (widget.context.repositories().courseRepository().items.length >= 1) {
        this.selectedCourseId =
            widget.context.repositories().courseRepository().items[0].Id;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: LoadingStack(
        isLoadingSCs: [
          widget.context.repositories().courseRepository().isLoadingSC,
        ],
        children: () => [
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 24, bottom: 12),
                child: Text(
                  "header",
                  style: TextStyle(
                    color: colorPrimary,
                    fontSize: p,
                    fontWeight: fontWeightBold,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 8, bottom: 12, left: 8, right: 8),
                child: Text(
                  "title",
                  style: TextStyle(
                    color: colorSecondaryDark,
                    fontSize: h3,
                    fontWeight: fontWeightBold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 8, left: 8, right: 8),
                child: Text(
                  "description",
                  style: TextStyle(
                    color: colorGray,
                    fontSize: p,
                    fontWeight: fontWeightBold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Container(
                    height: (MediaQuery.of(context).size.width * 0.75) /
                        Ratio.ratio78,
                    child: ListView.builder(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      controller: this.scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.context
                          .repositories()
                          .courseRepository()
                          .items
                          .length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            this.scrollController.animateTo(
                                (MediaQuery.of(context).size.width * 0.75) *
                                    index,
                                duration: Duration(milliseconds: 250),
                                curve: Curves.ease);
                            this.selectedCourseId = widget.context
                                .repositories()
                                .courseRepository()
                                .items[index]
                                .Id;
                            widget.context
                                .repositories()
                                .courseRepository()
                                .forceValueNotify();
                          },
                          child: CourseItem(
                            index: index,
                            context: widget.context,
                            config: widget.config,
                            margin: EdgeInsets.only(left: 8, right: 16),
                            image: widget.context
                                .repositories()
                                .courseRepository()
                                .items[index]
                                .Image,
                            title: widget.context
                                .repositories()
                                .courseRepository()
                                .items[index]
                                .Title,
                            description: widget.context
                                .repositories()
                                .courseRepository()
                                .items[index]
                                .Description,
                            isActive: this.selectedCourseId ==
                                widget.context
                                    .repositories()
                                    .courseRepository()
                                    .items[index]
                                    .Id,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              CurveButton(
                margin: EdgeInsets.only(left: 16, right: 16),
                title: "continue_button",
                onClick: () {
                  widget.context
                      .repositories()
                      .discoveryRepository()
                      .addCourse(this.selectedCourseId);
                  widget.context
                      .repositories()
                      .authenticationRepository()
                      .setCourseId(this.selectedCourseId);
                  widget.parentPageRepository.nextPage();
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
