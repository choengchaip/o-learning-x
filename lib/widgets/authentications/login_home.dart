import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_learning_x/configs/config.dart';
import 'package:o_learning_x/cores/context.dart';
import 'package:o_learning_x/repositories/page_repository.dart';
import 'package:o_learning_x/styles/colors.dart';
import 'package:o_learning_x/styles/fonts.dart';
import 'package:o_learning_x/widgets/authentications/authentication_background.dart';
import 'package:o_learning_x/widgets/commons/curve_button.dart';

class LoginHome extends StatefulWidget {
  final IContext context;
  final IConfig config;
  final PageRepository parentPageRepository;

  LoginHome({
    required this.context,
    required this.config,
    required this.parentPageRepository,
  });

  @override
  _LoginHomeState createState() {
    return _LoginHomeState();
  }
}

class _LoginHomeState extends State<LoginHome> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        bottom: MediaQuery.of(context).padding.bottom + 16,
        left: 16,
        right: 16,
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 16, bottom: 16),
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    // Go to register feature
                  },
                  child: Container(
                    child: Text(
                      "sign_up",
                      style: TextStyle(
                        color: colorGray,
                        fontSize: p,
                        fontWeight: fontWeightBold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 8, bottom: 32, left: 8, right: 8),
            child: Text(
              "title",
              style: TextStyle(
                color: colorSecondaryDark,
                fontSize: h3,
                fontWeight: fontWeightBold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          AuthenticationBackground(),
          Container(
            padding: EdgeInsets.only(top: 8, bottom: 8),
            child: Text(
              "terms_and_conditions",
              style: TextStyle(
                color: colorSecondaryDark,
                fontSize: s2,
                fontWeight: fontWeightBold,
              ),
            ),
          ),
          CurveButton(
            title: "login_button",
            onClick: () {
              widget.parentPageRepository.nextPage();
            },
          ),
        ],
      ),
    );
  }
}
