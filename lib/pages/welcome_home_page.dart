import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_learning_x/configs/config.dart';
import 'package:o_learning_x/cores/context.dart';
import 'package:o_learning_x/features/login_feature.dart';
import 'package:o_learning_x/middlewares/scaffold_middle_ware.dart';
import 'package:o_learning_x/pages/base_page.dart';
import 'package:o_learning_x/repositories/page_repository.dart';
import 'package:o_learning_x/styles/colors.dart';
import 'package:o_learning_x/styles/fonts.dart';
import 'package:o_learning_x/widgets/commons/curve_button.dart';
import 'package:o_learning_x/widgets/welcomes/welcome_infomation.dart';

class WelcomeHomePage extends StatefulWidget {
  final IContext context;
  final IConfig config;
  final PageRepository parentPageRepository;

  WelcomeHomePage({
    required this.context,
    required this.config,
    required this.parentPageRepository,
  });

  @override
  State<StatefulWidget> createState() {
    return WelcomeHomePageState();
  }
}

class WelcomeHomePageState extends State<WelcomeHomePage> {
  late PageRepository pageRepository;

  @override
  void initState() {
    super.initState();

    this.pageRepository = PageRepository();
    this.pageRepository.initial();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        bottom: MediaQuery.of(context).padding.bottom + 16,
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return ScaffoldMiddleWare(
                            context: widget.context,
                            config: widget.config,
                            child: LoginFeature(
                              context: widget.context,
                              config: widget.config,
                            ),
                          );
                        },
                      ),
                    );
                  },
                  child: Container(
                    child: Text(
                      widget.context.localeRepository().getString("login_button"),
                      style: TextStyle(
                        color: colorGray,
                        fontSize: p,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: BasePage(
                pageRepository: this.pageRepository,
                widgets: [
                  WelcomeInformation(
                    context: widget.context,
                    config: widget.config,
                    logoImage: 'lib/statics/logo.png',
                    title: widget.context.localeRepository().getString("learn_to_code_title"),
                    description: widget.context.localeRepository().getString("learn_to_code_description"),
                  ),
                  WelcomeInformation(
                    context: widget.context,
                    config: widget.config,
                    logoImage: 'lib/statics/logo.png',
                    title: widget.context.localeRepository().getString("build_project_title"),
                    description: widget.context.localeRepository().getString("build_project_description"),
                  ),
                  WelcomeInformation(
                    context: widget.context,
                    config: widget.config,
                    logoImage: 'lib/statics/logo.png',
                    title: widget.context.localeRepository().getString("learn_to_code_title"),
                    description: widget.context.localeRepository().getString("learn_to_code_description"),
                  ),
                ],
              ),
            ),
          ),
          CurveButton(
            margin: EdgeInsets.only(
              left: 16,
              right: 16,
            ),
            onClick: () {
              if (this.pageRepository.isLastPage) {
                widget.parentPageRepository.nextPage();
              } else {
                this.pageRepository.nextPage();
              }
            },
            title: widget.context.localeRepository().getString("get_started_button"),
          ),
        ],
      ),
    );
  }
}
