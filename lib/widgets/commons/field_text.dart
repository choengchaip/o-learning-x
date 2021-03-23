import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'field.dart';

class FieldText extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? placeholder;
  final Function(String)? onChanged;
  final String? initialValue;
  final Color? borderColor;
  final Color? backgroundColor;
  final bool? autofocus;
  final EdgeInsetsGeometry? padding;
  final TextStyle? fontStyle;

  FieldText({
    required this.controller,
    this.focusNode,
    this.placeholder,
    this.onChanged,
    this.initialValue,
    this.borderColor,
    this.backgroundColor,
    this.autofocus,
    this.padding,
    this.fontStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Field(
      initialValue: this.initialValue,
      controller: this.controller,
      textInputType: TextInputType.emailAddress,
      focusNode: this.focusNode,
      fontStyle: this.fontStyle,
      placeholder: this.placeholder,
      onChanged: this.onChanged,
      autofocus: this.autofocus,
      padding: this.padding,
      obscureText: false,
      borderColor: this.borderColor,
      backgroundColor: this.backgroundColor,
    );
  }
}
