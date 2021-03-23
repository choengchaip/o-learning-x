import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_learning_x/configs/config.dart';
import 'package:o_learning_x/cores/context.dart';
import 'package:o_learning_x/features/main_feature.dart';
import 'package:o_learning_x/middlewares/scaffold_middle_ware.dart';
import 'package:o_learning_x/repositories/page_repository.dart';
import 'package:o_learning_x/styles/colors.dart';
import 'package:o_learning_x/styles/fonts.dart';
import 'package:o_learning_x/widgets/commons/curve_button.dart';
import 'package:o_learning_x/widgets/commons/field_email.dart';
import 'package:o_learning_x/widgets/commons/header_back_button.dart';

class LoginPassword extends StatefulWidget {
  final IContext context;
  final IConfig config;
  final PageRepository parentPageRepository;

  LoginPassword({
    required this.context,
    required this.config,
    required this.parentPageRepository,
  });

  @override
  _LoginPasswordState createState() {
    return _LoginPasswordState();
  }
}

class _LoginPasswordState extends State<LoginPassword> {
  final formKey = GlobalKey<FormState>();
  late StreamController<bool> passwordValid;
  late TextEditingController passwordText;
  late FocusNode passwordFocus;

  @override
  void initState() {
    super.initState();

    this.passwordValid = StreamController<bool>();
    this.passwordValid.add(false);
    this.passwordText = TextEditingController(text: "");
    this.passwordFocus = FocusNode();
    // this.passwordFocus.requestFocus();

    if (widget.context
        .repositories()
        .authenticationRepository()
        .passwordText
        .isNotEmpty) {
      this.passwordValid.add(true);
    }
  }

  @override
  void dispose() {
    super.dispose();

    this.passwordValid.close();
  }

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
          HeaderBackButton(
            backTitle: "back",
            onBack: () {
              this.passwordFocus.unfocus();
              widget.parentPageRepository.prevPage();
            },
            tailTitle: '2/2',
          ),
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 48),
                    child: Text(
                      "password_title",
                      style: TextStyle(
                        fontSize: h3,
                        fontWeight: fontWeightBold,
                      ),
                    ),
                  ),
                  Container(
                    child: Form(
                      key: formKey,
                      child: TextFormField(
                        obscureText: true,
                        focusNode: this.passwordFocus,
                        decoration: InputDecoration(
                          errorStyle: TextStyle(height: 0),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: colorGray,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: colorGray,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: colorGray,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: colorGray,
                            ),
                          ),
                          contentPadding: EdgeInsets.only(
                              top: 12, bottom: 12, left: 16, right: 16),
                        ),
                      ),
                    ),
                  ),
                  StreamBuilder(
                    stream: passwordValid.stream,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      }

                      return CurveButton(
                        margin: EdgeInsets.only(top: 12, bottom: 12),
                        title: "continue_button",
                        onClick: () async {
                          this.passwordFocus.unfocus();
                          widget.context
                              .repositories()
                              .authenticationRepository()
                              .setPassword(this.passwordText.text);
                          await widget.context
                              .repositories()
                              .authenticationRepository()
                              .login();
                          if (!widget.context
                              .repositories()
                              .authenticationRepository()
                              .isError) {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(builder: (context) {
                              return ScaffoldMiddleWare(
                                  context: widget.context,
                                  config: widget.config,
                                  child: MainFeature(
                                    context: widget.context,
                                    config: widget.config,
                                  ));
                            }), (route) => false);
                          }
                        },
                      );
                    },
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "forget_password_title",
                      style: TextStyle(
                        fontSize: p,
                        color: colorGray,
                        fontWeight: fontWeightBold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
