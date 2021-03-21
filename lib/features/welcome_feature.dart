import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_learning_x/configs/config.dart';
import 'package:o_learning_x/cores/context.dart';
import 'package:o_learning_x/pages/base_page.dart';
import 'package:o_learning_x/pages/welcome_discovery_page.dart';
import 'package:o_learning_x/pages/welcome_home_page.dart';
import 'package:o_learning_x/pages/welcome_introduce_page.dart';
import 'package:o_learning_x/repositories/page_repository.dart';

class WelcomeFeature extends StatefulWidget {
  final IContext context;
  final IConfig config;

  WelcomeFeature({
    required this.context,
    required this.config,
  });

  @override
  State<StatefulWidget> createState() {
    return WelcomeFeatureState();
  }
}

class WelcomeFeatureState extends State<WelcomeFeature> {
  late PageRepository pageRepository;

  @override
  void initState() {
    super.initState();

    this.pageRepository = PageRepository();
    this.pageRepository.initial();
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
                  WelcomeHomePage(
                    context: widget.context,
                    config: widget.config,
                    parentPageRepository: this.pageRepository,
                  ),
                  WelcomeIntroducePage(
                    context: widget.context,
                    config: widget.config,
                    parentPageRepository: this.pageRepository,
                  ),
                  WelcomeDiscoveryPage(
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
