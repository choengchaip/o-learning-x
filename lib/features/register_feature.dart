import 'package:flutter/cupertino.dart';
import 'package:o_learning_x/configs/config.dart';
import 'package:o_learning_x/cores/context.dart';
import 'package:o_learning_x/pages/base_page.dart';
import 'package:o_learning_x/repositories/page_repository.dart';
import 'package:o_learning_x/widgets/authentications/register_email.dart';
import 'package:o_learning_x/widgets/authentications/register_home.dart';
import 'package:o_learning_x/widgets/authentications/register_name.dart';
import 'package:o_learning_x/widgets/authentications/register_password.dart';
import 'package:o_learning_x/widgets/commons/loading_stack.dart';

class RegisterFeature extends StatefulWidget {
  final IContext context;
  final IConfig config;

  RegisterFeature({
    required this.context,
    required this.config,
  });

  @override
  State<StatefulWidget> createState() {
    return _RegisterFeatureState();
  }
}

class _RegisterFeatureState extends State<RegisterFeature> {
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
                      RegisterHome(
                        context: widget.context,
                        config: widget.config,
                        parentPageRepository: this.pageRepository,
                      ),
                      RegisterName(
                        context: widget.context,
                        config: widget.config,
                        parentPageRepository: this.pageRepository,
                      ),
                      RegisterEmail(
                        context: widget.context,
                        config: widget.config,
                        parentPageRepository: this.pageRepository,
                      ),
                      RegisterPassword(
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
