import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_learning_x/configs/config.dart';
import 'package:o_learning_x/cores/context.dart';
import 'package:o_learning_x/repositories/page_repository.dart';
import 'package:o_learning_x/styles/colors.dart';

class LeaderBoardNavBar extends StatelessWidget {
  final IContext context;
  final IConfig config;
  final PageRepository parentPageRepository;
  StreamController<int> navBar = StreamController<int>();

  LeaderBoardNavBar({
    required this.context,
    required this.config,
    required this.parentPageRepository,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: navBar.stream,
      builder: (BuildContext context, snapshot) {
        if (!snapshot.hasData) {
          this.navBar.add(0);
          return Container();
        }

        return Container(
          color: colorPrimaryLight,
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Column(
            children: [
              Container(
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          this.navBar.add(0);
                          this.parentPageRepository.jumpTo(0);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          color: colorPrimaryLight,
                          padding: EdgeInsets.only(
                            top: 16,
                            bottom: 16,
                          ),
                          child: Text(
                            this.context.localeRepository().getString("leagues"),
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          this.navBar.add(1);
                          this.parentPageRepository.jumpTo(1);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(
                            top: 16,
                            bottom: 16,
                          ),
                          color: colorPrimaryLight,
                          child: Text(
                            this.context.localeRepository().getString("friends"),
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 150),
                alignment: snapshot.data == 0
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                child: Container(
                  height: 3,
                  width: MediaQuery.of(context).size.width / 2,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
