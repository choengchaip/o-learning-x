// ignore_for_file: non_constant_identifier_names
import 'package:flutter/cupertino.dart';

class ChapterModel {
  final String? Id;
  final String? Image;
  final IconData? Icon;
  final String Title;
  final String? Description;
  final bool? CanLearn;
  final bool? IsPassed;
  final int? Progress;

  ChapterModel({
    this.Id,
    this.Image,
    this.Icon,
    required this.Title,
    this.Description,
    this.CanLearn,
    this.IsPassed,
    this.Progress,
  });
}
