import 'package:flutter/cupertino.dart';
import 'package:o_learning_x/configs/config.dart';
import 'package:o_learning_x/cores/context.dart';
import 'package:o_learning_x/repositories/page_repository.dart';
import 'package:o_learning_x/widgets/accounts/account_home.dart';
import 'package:o_learning_x/widgets/commons/loading_stack.dart';

class AccountPage extends StatefulWidget {
  final IContext context;
  final IConfig config;

  final PageRepository parentPageRepository;

  AccountPage({
    required this.context,
    required this.config,
    required this.parentPageRepository,
  });

  @override
  State<StatefulWidget> createState() {
    return AccountPageState();
  }
}

class AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: LoadingStack(
        isLoadingSCs: [],
        children: () => [
          AccountHome(
            context: widget.context,
            config: widget.config,
            rootPageRepository: widget.parentPageRepository,
          ),
        ],
      ),
    );
  }
}
