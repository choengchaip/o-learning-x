import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_learning_x/configs/config.dart';
import 'package:o_learning_x/cores/context.dart';
import 'package:o_learning_x/repositories/page_repository.dart';
import 'package:o_learning_x/styles/colors.dart';
import 'package:o_learning_x/styles/fonts.dart';
import 'package:o_learning_x/widgets/commons/curve_button.dart';
import 'package:o_learning_x/widgets/commons/header_back_button.dart';

class ChangePasswordNewPassword extends StatefulWidget {
  final IContext context;
  final IConfig config;
  final PageRepository parentPageRepository;

  ChangePasswordNewPassword({
    required this.context,
    required this.config,
    required this.parentPageRepository,
  });

  @override
  _ChangePasswordNewPasswordState createState() {
    return _ChangePasswordNewPasswordState();
  }
}

class _ChangePasswordNewPasswordState extends State<ChangePasswordNewPassword> {
  final formKey = GlobalKey<FormState>();
  late StreamController<bool> passwordValid;
  late TextEditingController passwordText;
  late FocusNode passwordFocus;

  @override
  void initState() {
    this.passwordValid = StreamController<bool>();
    this.passwordValid.add(false);
    this.passwordText = TextEditingController(text: "");
    this.passwordFocus = FocusNode();
    this.passwordFocus.addListener(() {
      this.passwordText.selection = TextSelection.fromPosition(
          TextPosition(offset: this.passwordText.text.length));
    });

    super.initState();
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
            tailTitle: '2/3',
          ),
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 48),
                    child: Text(
                      "new_password_title",
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
                        controller: this.passwordText,
                        focusNode: this.passwordFocus,
                        decoration: InputDecoration(
                          errorStyle: TextStyle(height: 0),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: colorGray,),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: colorGray,),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: colorGray,),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: colorGray,),
                          ),
                          contentPadding: EdgeInsets.only(top: 12, bottom: 12, left: 16, right: 16),
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
                        onClick: () {
                          this.passwordFocus.unfocus();
                          widget.context.repositories().authenticationRepository().setNewPassword(this.passwordText.text);
                          widget.parentPageRepository.nextPage();
                        },
                      );
                    },
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
