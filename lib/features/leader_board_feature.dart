import 'package:flutter/cupertino.dart';
import 'package:o_learning_x/configs/config.dart';
import 'package:o_learning_x/cores/context.dart';
import 'package:o_learning_x/pages/base_page.dart';
import 'package:o_learning_x/pages/leader_board_friend_page.dart';
import 'package:o_learning_x/pages/leader_board_league_page.dart';
import 'package:o_learning_x/repositories/page_repository.dart';
import 'package:o_learning_x/widgets/commons/loading_stack.dart';
import 'package:o_learning_x/widgets/leader_board/leader_board_navbar.dart';

class LeaderBoardFeature extends StatefulWidget {
  final IContext context;
  final IConfig config;

  LeaderBoardFeature({
    required this.context,
    required this.config,
  });

  @override
  State<StatefulWidget> createState() {
    return LeaderBoardFeatureState();
  }
}

class LeaderBoardFeatureState extends State<LeaderBoardFeature> {
  late PageRepository pageRepository;

  @override
  void initState() {
    super.initState();

    this.pageRepository = PageRepository();
    this.pageRepository.initial();
    this.pageRepository.jumpTo(0);
  }

  @override
  void dispose() {
    this.pageRepository.dispose();

    super.dispose();
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
                LeaderBoardNavBar(
                  parentPageRepository: this.pageRepository,
                ),
                Expanded(
                  child: Container(
                    child: BasePage(
                      pageRepository: this.pageRepository,
                      widgets: [
                        LeaderBoardLeaguePage(
                          context: widget.context,
                          config: widget.config,
                          parentPageRepository: this.pageRepository,
                        ),
                        LeaderBoardFriendPage(
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
