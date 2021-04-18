import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_learning_x/configs/config.dart';
import 'package:o_learning_x/cores/context.dart';
import 'package:o_learning_x/styles/colors.dart';
import 'package:o_learning_x/styles/fonts.dart';
import 'package:o_learning_x/widgets/leader_board/leader_board_league_user_item.dart';

class LeaderBoardLeagueUser extends StatelessWidget {
  final IContext context;
  final IConfig config;

  LeaderBoardLeagueUser({
    required this.context,
    required this.config,
  });

  Widget getUserIcon(BuildContext context, String score) {
    switch (score) {
      case '1':
        return Container(
          width: 50,
          alignment: Alignment.center,
          margin: EdgeInsets.only(right: 6),
          padding: EdgeInsets.all(4.5),
          decoration:
              BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          child: Icon(
            Icons.star,
            color: Colors.yellow,
          ),
        );
      case '2':
        return Container(
          width: 50,
          alignment: Alignment.center,
          margin: EdgeInsets.only(right: 6),
          padding: EdgeInsets.all(4.5),
          decoration:
              BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          child: Icon(
            Icons.star,
            color: colorGray,
          ),
        );
      case '3':
        return Container(
          width: 50,
          alignment: Alignment.center,
          margin: EdgeInsets.only(right: 6),
          padding: EdgeInsets.all(4.5),
          decoration:
              BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          child: Icon(
            Icons.star,
            color: colorPrimary,
          ),
        );
      default:
        return Container(
          width: 50,
          alignment: Alignment.center,
          margin: EdgeInsets.only(right: 6),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(shape: BoxShape.circle),
          child: Text(
            score,
            style: TextStyle(
              fontSize: p,
              fontWeight: fontWeightBold,
              color: colorPrimary,
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: ListView.builder(
          padding: EdgeInsets.only(
            bottom: 20,
          ),
          itemCount: this.context.repositories().leaderBoardRepository().items.length,
          itemBuilder: (BuildContext context, int index) {
            return LeaderBoardLeagueUserItem(
              title: this.context.repositories().leaderBoardRepository().items[index].Title,
              score: this.context.repositories().leaderBoardRepository().items[index].Score.toString(),
              imageUrl: this.context.repositories().leaderBoardRepository().items[index].ImageURL,
              background: colorPrimaryLight
                  .withOpacity(index % 2 == 0 ? 0.25 : 0.15),
              icon: this.getUserIcon(context, (index + 1).toString()),
            );
          },
        ),
      ),
    );
  }
}
