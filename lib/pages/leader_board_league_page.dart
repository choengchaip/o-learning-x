import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_learning_x/configs/config.dart';
import 'package:o_learning_x/cores/context.dart';
import 'package:o_learning_x/repositories/page_repository.dart';
import 'package:o_learning_x/widgets/commons/loading_stack.dart';
import 'package:o_learning_x/widgets/leader_board/leader_board_league_user.dart';

import '../widgets/leader_board/leader_board_league_achievement.dart';

class LeaderBoardLeaguePage extends StatefulWidget {
  final IContext context;
  final IConfig config;

  final PageRepository parentPageRepository;

  LeaderBoardLeaguePage({
    required this.context,
    required this.config,
    required this.parentPageRepository,
  });

  @override
  State<StatefulWidget> createState() {
    return _LeaderBoardLeague();
  }
}

class _LeaderBoardLeague extends State<LeaderBoardLeaguePage> {
  @override
  void initState() {
    widget.context.repositories().leaderBoardRepository().fetch();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LoadingStack(
        isLoadingSCs: [
          widget.context.repositories().leaderBoardRepository().isLoadingSC,
        ],
        children: () => [
          Container(
            child: Column(
              children: [
                LeaderBoardLeagueAchievement(
                  localeRepository: widget.context.localeRepository(),
                ),
                LeaderBoardLeagueUser(
                  context: widget.context,
                  config: widget.config,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
