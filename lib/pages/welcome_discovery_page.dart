import 'package:flutter/cupertino.dart';
import 'package:o_learning_x/configs/config.dart';
import 'package:o_learning_x/cores/context.dart';
import 'package:o_learning_x/pages/base_page.dart';
import 'package:o_learning_x/repositories/page_repository.dart';
import 'package:o_learning_x/widgets/welcomes/welcome_discovery_choice.dart';
import 'package:o_learning_x/widgets/welcomes/welcome_discovery_course.dart';
import 'package:o_learning_x/widgets/welcomes/welcome_discovery_experience.dart';
import 'package:o_learning_x/widgets/welcomes/welcome_discovery_goal.dart';
import 'package:o_learning_x/widgets/welcomes/welcome_discovery_notification.dart';

class WelcomeDiscoveryPage extends StatefulWidget {
  final IContext context;
  final IConfig config;
  final PageRepository parentPageRepository;

  WelcomeDiscoveryPage({
    required this.context,
    required this.config,
    required this.parentPageRepository,
  });

  @override
  State<StatefulWidget> createState() {
    return _WelcomeDiscoveryPageState();
  }
}

class _WelcomeDiscoveryPageState extends State<WelcomeDiscoveryPage> {
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
          Expanded(
            child: Container(
              child: BasePage(
                pageRepository: this.pageRepository,
                widgets: [
                  WelcomeDiscoveryChoice(
                    context: widget.context,
                    config: widget.config,
                    parentPageRepository: this.pageRepository,
                    rootPageRepository: widget.parentPageRepository,
                  ),
                  WelcomeDiscoveryExperience(
                    context: widget.context,
                    config: widget.config,
                    parentPageRepository: this.pageRepository,
                    rootPageRepository: widget.parentPageRepository,
                  ),
                  WelcomeDiscoveryCourse(
                    context: widget.context,
                    config: widget.config,
                    parentPageRepository: this.pageRepository,
                    rootPageRepository: widget.parentPageRepository,
                  ),
                  WelcomeDiscoveryGoal(
                    context: widget.context,
                    config: widget.config,
                    parentPageRepository: this.pageRepository,
                    rootPageRepository: widget.parentPageRepository,
                  ),
                  WelcomeDiscoveryNotification(
                    context: widget.context,
                    config: widget.config,
                    parentPageRepository: this.pageRepository,
                    rootPageRepository: widget.parentPageRepository,
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
