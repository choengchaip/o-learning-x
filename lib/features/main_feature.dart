import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_learning_x/configs/config.dart';
import 'package:o_learning_x/cores/context.dart';
import 'package:o_learning_x/features/category_feature.dart';
import 'package:o_learning_x/features/leader_board_feature.dart';
import 'package:o_learning_x/pages/account_page.dart';
import 'package:o_learning_x/pages/base_page.dart';
import 'package:o_learning_x/pages/category_page.dart';
import 'package:o_learning_x/pages/course_page.dart';
import 'package:o_learning_x/repositories/page_repository.dart';
import 'package:o_learning_x/styles/colors.dart';
import 'package:o_learning_x/styles/fonts.dart';
import 'package:o_learning_x/utils/object_helper.dart';

class MainFeature extends StatefulWidget {
  final IContext context;
  final IConfig config;

  MainFeature({
    required this.context,
    required this.config,
  });

  @override
  State<StatefulWidget> createState() {
    return MainFeatureState();
  }
}

class MainFeatureState extends State<MainFeature> {
  late PageRepository pageRepository;

  @override
  void initState() {
    this.pageRepository = PageRepository();
    this.pageRepository.initial();
    this.pageRepository.jumpTo(0);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: widget.context.localeRepository().isLoadingSC.stream,
      builder: (context, snapshot) {
        if (ObjectHelper.isSnapshotStateLoading(snapshot)) {
          return Center(
            child: Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(colorSecondary),
              ),
            ),
          );
        }

        return Container(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: BasePage(
                    pageRepository: this.pageRepository,
                    widgets: [
                      CoursePage(
                        context: widget.context,
                        config: widget.config,
                      ),
                      CategoryFeature(
                        context: widget.context,
                        config: widget.config,
                      ),
                      LeaderBoardFeature(
                        context: widget.context,
                        config: widget.config,
                      ),
                      AccountPage(
                        context: widget.context,
                        config: widget.config,
                        parentPageRepository: this.pageRepository,
                      )
                    ],
                  ),
                ),
              ),
              StreamBuilder<int>(
                stream: this.pageRepository.pageIndexSC.stream,
                builder: (context, snapshot) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          color: colorGrayLight,
                          offset: Offset(0, -0.5),
                          blurRadius: 2)
                    ]),
                    padding: EdgeInsets.only(
                      top: 6,
                      bottom: 12 + MediaQuery.of(context).padding.bottom,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              this.pageRepository.jumpTo(0);
                            },
                            child: Container(
                              color: Colors.transparent,
                              child: Column(
                                children: [
                                  Container(
                                    height: 30,
                                    width: 50,
                                    child: Icon(
                                      Icons.flag,
                                      color: snapshot.data == 0
                                          ? colorPrimary
                                          : colorGrayDark,
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "?????????????????????",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: s,
                                        color: snapshot.data == 0
                                            ? colorPrimary
                                            : colorGrayDark,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              this.pageRepository.jumpTo(1);
                            },
                            child: Container(
                              color: Colors.transparent,
                              child: Column(
                                children: [
                                  Container(
                                    height: 30,
                                    width: 50,
                                    child: Icon(
                                      Icons.book_rounded,
                                      color: snapshot.data == 1
                                          ? colorPrimary
                                          : colorGrayDark,
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "?????????????????????",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: s,
                                        color: snapshot.data == 1
                                            ? colorPrimary
                                            : colorGrayDark,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              this.pageRepository.jumpTo(2);
                            },
                            child: Container(
                              color: Colors.transparent,
                              child: Column(
                                children: [
                                  Container(
                                    height: 30,
                                    width: 50,
                                    child: Icon(
                                      Icons.stars,
                                      color: snapshot.data == 2
                                          ? colorPrimary
                                          : colorGrayDark,
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "???????????????",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: s,
                                        color: snapshot.data == 2
                                            ? colorPrimary
                                            : colorGrayDark,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              this.pageRepository.jumpTo(3);
                            },
                            child: Container(
                              color: Colors.transparent,
                              child: Column(
                                children: [
                                  Container(
                                    height: 30,
                                    width: 50,
                                    child: Icon(
                                      Icons.person,
                                      color: snapshot.data == 3
                                          ? colorPrimary
                                          : colorGrayDark,
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "???????????????",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: s,
                                        color: snapshot.data == 3
                                            ? colorPrimary
                                            : colorGrayDark,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
