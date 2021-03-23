import 'package:flutter/cupertino.dart';
import 'package:o_learning_x/configs/config.dart';
import 'package:o_learning_x/cores/context.dart';
import 'package:o_learning_x/pages/base_page.dart';
import 'package:o_learning_x/repositories/page_repository.dart';
import 'package:o_learning_x/widgets/authentications/login_email.dart';
import 'package:o_learning_x/widgets/authentications/login_home.dart';
import 'package:o_learning_x/widgets/authentications/login_password.dart';
import 'package:o_learning_x/widgets/commons/loading_stack.dart';

class LoginFeature extends StatefulWidget {
  final IContext context;
  final IConfig config;

  LoginFeature({
    required this.context,
    required this.config,
  });

  @override
  State<StatefulWidget> createState() {
    return _LoginFeatureState();
  }
}

class _LoginFeatureState extends State<LoginFeature> {
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
      child: LoadingStack(
        isLoadingSCs: [
          widget.context.repositories().authenticationRepository().isLoadingSC,
        ],
        children: () => [
          Column(
            children: [
              Expanded(
                child: Container(
                  child: BasePage(
                    pageRepository: this.pageRepository,
                    widgets: [
                      LoginHome(
                        context: widget.context,
                        config: widget.config,
                        parentPageRepository: this.pageRepository,
                      ),
                      LoginEmail(
                        context: widget.context,
                        config: widget.config,
                        parentPageRepository: this.pageRepository,
                      ),
                      LoginPassword(
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
        ],
      ),
    );
  }
}
