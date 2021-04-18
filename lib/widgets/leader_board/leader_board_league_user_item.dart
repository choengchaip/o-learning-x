import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_learning_x/styles/fonts.dart';
import 'package:o_learning_x/widgets/commons/cached_image.dart';

class LeaderBoardLeagueUserItem extends StatelessWidget {
  final String title;
  final String score;
  final String imageUrl;
  final Color background;
  final Widget icon;

  LeaderBoardLeagueUserItem({
    required this.title,
    required this.score,
    required this.imageUrl,
    required this.background,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: this.background,
      padding: EdgeInsets.only(top: 12, bottom: 12, left: 8, right: 8),
      child: Row(
        children: [
          this.icon,
          CachedImage(
            image: this.imageUrl,
            errorImage: 'lib/statics/default/user.png',
            width: 45,
            height: 45,
            margin: EdgeInsets.only(
              right: 24,
            ),
            shape: BoxShape.circle,
          ),
          Expanded(
            child: Container(
              child: Text(
                this.title,
                style: TextStyle(
                  fontSize: p,
                  fontWeight: fontWeightBold,
                ),
              ),
            ),
          ),
          Container(
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 4),
                  margin: EdgeInsets.only(right: 8),
                  child: Icon(
                    Icons.leaderboard,
                    color: Colors.greenAccent,
                    size: 24,
                  ),
                ),
                Container(
                  child: Text(
                    this.score,
                    style: TextStyle(
                      fontSize: p,
                      fontWeight: fontWeightBold,
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
