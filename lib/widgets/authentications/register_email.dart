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

class RegisterEmail extends StatefulWidget {
  final IContext context;
  final IConfig config;
  final PageRepository parentPageRepository;

  RegisterEmail({
    required this.context,
    required this.config,
    required this.parentPageRepository,
  });

  @override
  _RegisterEmailState createState() {
    return _RegisterEmailState();
  }
}

class _RegisterEmailState extends State<RegisterEmail> {
  final formKey = GlobalKey<FormState>();
  late StreamController<bool> emailValid;
  late TextEditingController emailText;
  late FocusNode emailFocus;

  @override
  void initState() {
    super.initState();

    this.emailValid = StreamController<bool>();
    this.emailValid.add(false);
    this.emailText = TextEditingController(text: "");
    this.emailFocus = FocusNode();
    // this.emailFocus.requestFocus();

    if (widget.context
        .repositories()
        .authenticationRepository()
        .emailText
        .isNotEmpty) {
      this.emailValid.add(true);
    }
  }

  @override
  void dispose() {
    super.dispose();

    this.emailValid.close();
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
              this.emailFocus.unfocus();
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
                      "email_title",
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
                        controller: this.emailText,
                        focusNode: this.emailFocus,
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
                    stream: emailValid.stream,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      }

                      return CurveButton(
                        margin: EdgeInsets.only(top: 12, bottom: 12),
                        title: "continue_button",
                        onClick: () {
                          this.emailFocus.unfocus();
                          widget.context.repositories().authenticationRepository().setEmail(this.emailText.text);
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
