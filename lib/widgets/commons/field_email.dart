import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_learning_x/utils/validate_helper.dart';
import 'field.dart';

class FieldEmail extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? placeholder;
  final Function(String)? onChanged;
  final String? initialValue;

  FieldEmail({
    required this.controller,
    this.focusNode,
    this.placeholder,
    this.onChanged,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Field(
      initialValue: this.initialValue,
      controller: this.controller,
      textInputType: TextInputType.emailAddress,
      focusNode: this.focusNode,
      placeholder: this.placeholder,
      validator: (value) {
        if (ValidateHelper.isEmailValid(value ?? "")) {
          return null;
        }

        return "";
      },
      onChanged: this.onChanged,
      obscureText: false,
    );
  }
}
