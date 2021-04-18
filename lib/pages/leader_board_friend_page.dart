import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_learning_x/configs/config.dart';
import 'package:o_learning_x/cores/context.dart';
import 'package:o_learning_x/repositories/page_repository.dart';

class LeaderBoardFriendPage extends StatefulWidget {
  final IContext context;
  final IConfig config;

  final PageRepository parentPageRepository;

  LeaderBoardFriendPage({
    required this.context,
    required this.config,
    required this.parentPageRepository,
  });

  @override
  State<StatefulWidget> createState() {
    return _LeaderBoardFriend();
  }
}

class _LeaderBoardFriend extends State<LeaderBoardFriendPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Text("No Available"),
          ),
          // LeaderBoardFriendListFeature(
          //   mockItems: mockLeaderBoardFriendItems,
          // )
        ],
      ),
    );
  }
}
