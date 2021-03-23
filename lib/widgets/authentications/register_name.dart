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

class RegisterName extends StatefulWidget {
  final IContext context;
  final IConfig config;
  final PageRepository parentPageRepository;

  RegisterName({
    required this.context,
    required this.config,
    required this.parentPageRepository,
  });

  @override
  _RegisterNameState createState() {
    return _RegisterNameState();
  }
}

class _RegisterNameState extends State<RegisterName> {
  final formKey = GlobalKey<FormState>();
  late StreamController<bool> nameValid;
  late TextEditingController nameText;
  late FocusNode nameFocus;

  @override
  void initState() {
    super.initState();

    this.nameValid = StreamController<bool>();
    this.nameValid.add(false);
    this.nameText = TextEditingController(text: "");
    this.nameFocus = FocusNode();

    if (widget.context
        .repositories()
        .authenticationRepository()
        .nameText
        .isNotEmpty) {
      this.nameValid.add(true);
    }
  }

  @override
  void dispose() {
    super.dispose();

    this.nameValid.close();
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
              this.nameFocus.unfocus();
              widget.parentPageRepository.prevPage();
            },
            tailTitle: '1/3',
          ),
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 48),
                    child: Text(
                      "name_title",
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
                        controller: this.nameText,
                        focusNode: this.nameFocus,
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
                    stream: nameValid.stream,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      }

                      return CurveButton(
                        margin: EdgeInsets.only(top: 12, bottom: 12),
                        title: "continue_button",
                        onClick: () {
                          this.nameFocus.unfocus();
                          widget.context.repositories().authenticationRepository().setName(this.nameText.text);
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
