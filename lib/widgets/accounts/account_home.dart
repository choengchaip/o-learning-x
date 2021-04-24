import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_learning_x/configs/config.dart';
import 'package:o_learning_x/cores/context.dart';
import 'package:o_learning_x/features/change_password_feature.dart';
import 'package:o_learning_x/middlewares/scaffold_middle_ware.dart';
import 'package:o_learning_x/pages/launch_screen.dart';
import 'package:o_learning_x/repositories/page_repository.dart';
import 'package:o_learning_x/styles/colors.dart';
import 'package:o_learning_x/styles/fonts.dart';
import 'package:o_learning_x/widgets/commons/cached_image.dart';

class AccountHome extends StatefulWidget {
  final IContext context;
  final IConfig config;

  final PageRepository rootPageRepository;

  AccountHome({
    required this.context,
    required this.config,
    required this.rootPageRepository,
  });

  @override
  State<StatefulWidget> createState() {
    return _AccountHome();
  }
}

class _AccountHome extends State<AccountHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 16,
              bottom: 16,
              left: 16,
              right: 16,
            ),
            color: colorPrimaryLight,
            child: Text(
              "title",
              style: TextStyle(
                color: Colors.white,
                fontSize: p,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedImage(
                  height: 95,
                  width: 95,
                  image: "",
                  errorImage: "lib/statics/default/user.png",
                  shape: BoxShape.circle,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(
                      top: 8,
                      bottom: 8,
                      left: 16,
                      right: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            widget.context
                                .repositories()
                                .authenticationRepository()
                                .nameText,
                            style: TextStyle(
                              fontSize: h5,
                              fontWeight: fontWeightBold,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            widget.context
                                .repositories()
                                .authenticationRepository()
                                .emailText,
                            style: TextStyle(
                              fontSize: p,
                              color: colorGray,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => ScaffoldMiddleWare(
                                  context: widget.context,
                                  config: widget.config,
                                  child: ChangePasswordFeature(
                                    context: widget.context,
                                    config: widget.config,
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            child: Text(
                              widget.context.localeRepository().getString("account_change_password_button"),
                              style: TextStyle(
                                fontSize: p,
                                color: colorPrimary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              child: ListView(
                padding: EdgeInsets.all(8),
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      bottom: 16,
                    ),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0, 2),
                            blurRadius: 4,
                            spreadRadius: 1),
                      ],
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            bottom: 8,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  right: 16,
                                ),
                                child: Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 64,
                                ),
                              ),
                              Container(
                                child: Text(
                                  widget.context
                                      .repositories()
                                      .authenticationRepository()
                                      .star
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: h1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            bottom: 16,
                          ),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.context.localeRepository().getString("account_star_description"),
                            style: TextStyle(
                              color: colorGray,
                              fontSize: s,
                            ),
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  widget.rootPageRepository.jumpTo(1);
                                },
                                child: Container(
                                  // margin: EdgeInsets.only(
                                  //   right: 16,
                                  // ),
                                  child: Text(
                                    widget.context.localeRepository().getString("account_quiz_button"),
                                    style: TextStyle(
                                      color: colorPrimary,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      bottom: 16,
                    ),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0, 2),
                            blurRadius: 4,
                            spreadRadius: 1),
                      ],
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            bottom: 8,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  right: 16,
                                ),
                                child: Icon(
                                  Icons.leaderboard,
                                  color: Colors.green,
                                  size: 64,
                                ),
                              ),
                              Container(
                                child: Text(
                                  widget.context
                                      .repositories()
                                      .authenticationRepository()
                                      .progress
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: h1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            bottom: 16,
                          ),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.context.localeRepository().getString("account_score_description"),
                            style: TextStyle(
                              color: colorGray,
                              fontSize: s,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            widget.rootPageRepository.jumpTo(2);
                          },
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  child: Text(
                                    widget.context.localeRepository().getString("account_score_button"),
                                    style: TextStyle(
                                      color: colorPrimary,
                                    ),
                                  ),
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
            ),
          ),
          GestureDetector(
            onTap: () async {
              widget.context.repositories().authenticationRepository().logout();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) {
                return LaunchScreen(
                  launchScreenRepository: PageRepository(),
                );
              }), (route) => false);
              // pageLauncher(Index(), context);
            },
            child: Container(
              alignment: Alignment.center,
              color: Colors.redAccent,
              padding: EdgeInsets.all(16),
              child: Text(
                widget.context.localeRepository().getString("logout"),
                style: TextStyle(
                  fontSize: h4,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
