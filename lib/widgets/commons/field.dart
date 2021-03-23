import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_learning_x/styles/colors.dart';
import 'package:o_learning_x/styles/fonts.dart';

// ignore: must_be_immutable
class Field extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final String? placeholder;
  final Function(String)? onChanged;
  final TextInputType? textInputType;
  final bool? obscureText;
  final Color? backgroundColor;
  bool? autofocus;
  Color? borderColor;
  String? initialValue;
  EdgeInsetsGeometry? padding;
  TextStyle? fontStyle;

  Field({
    required this.controller,
    this.validator,
    this.textInputType,
    this.focusNode,
    this.placeholder,
    this.obscureText,
    this.onChanged,
    this.autofocus,
    this.initialValue,
    this.borderColor,
    this.backgroundColor,
    this.padding,
    this.fontStyle,
  }) {
    if (this.initialValue != null) {
      this.controller.text = this.initialValue!;
    }

    if (this.borderColor == null) {
      this.borderColor = colorGray;
    }
    if (this.autofocus == null) {
      this.autofocus = false;
    }
    if (this.padding == null) {
      this.padding = EdgeInsets.only(top: 12, bottom: 12, left: 16, right: 16);
    }
    if (this.fontStyle == null) {
      this.fontStyle = TextStyle(
        fontSize: h4,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: this.onChanged,
      validator: this.validator,
      controller: this.controller,
      focusNode: this.focusNode,
      autofocus: this.autofocus!,
      decoration: InputDecoration(
        errorStyle: TextStyle(height: 0),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: this.borderColor!),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: this.borderColor!),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: this.borderColor!),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: this.borderColor!),
        ),
        contentPadding: this.padding,
        hintText: this.placeholder,
        hintStyle: this.fontStyle,
        fillColor: this.backgroundColor,
      ),
      cursorColor: this.fontStyle!.color,
      style: this.fontStyle,
      obscureText: this.obscureText ?? false,
      keyboardType: this.textInputType,
    );
  }
}
