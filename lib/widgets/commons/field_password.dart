import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_learning_x/utils/validate_helper.dart';
import 'field.dart';

class FieldPassword extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? placeholder;
  final Function(String)? onChanged;
  final String? initialValue;

  FieldPassword({
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
      focusNode: this.focusNode,
      placeholder: this.placeholder,
      onChanged: this.onChanged,
      validator: (String? value) {
        if (ValidateHelper.isPasswordValid(value ?? "")) {
          return null;
        }

        return '';
      },
      obscureText: true,
    );
  }
}
