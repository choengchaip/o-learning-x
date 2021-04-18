import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_learning_x/configs/config.dart';
import 'package:o_learning_x/cores/context.dart';
import 'package:o_learning_x/pages/base_page.dart';
import 'package:o_learning_x/repositories/page_repository.dart';
import 'package:o_learning_x/widgets/change_password/change_password_confirm_password.dart';
import 'package:o_learning_x/widgets/change_password/change_password_new_password.dart';
import 'package:o_learning_x/widgets/change_password/change_password_password.dart';
import 'package:o_learning_x/widgets/commons/loading_stack.dart';

class ChangePasswordFeature extends StatefulWidget {
  final IContext context;
  final IConfig config;

  ChangePasswordFeature({
    required this.context,
    required this.config,
  });

  @override
  State<StatefulWidget> createState() {
    return _ChangePasswordFeature();
  }
}

class _ChangePasswordFeature extends State<ChangePasswordFeature> {
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
    return Container(
      child: LoadingStack(
        isLoadingSCs: [],
        children: () => [
          Container(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    child: BasePage(
                      pageRepository: this.pageRepository,
                      widgets: [
                        ChangePasswordPassword(
                          context: widget.context,
                          config: widget.config,
                          parentPageRepository: this.pageRepository,
                        ),
                        ChangePasswordNewPassword(
                          context: widget.context,
                          config: widget.config,
                          parentPageRepository: this.pageRepository,
                        ),
                        ChangePasswordConfirmPassword(
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
          ),
        ],
      ),
    );
  }
}
