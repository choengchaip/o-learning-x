// ignore_for_file: non_constant_identifier_names
import 'package:o_learning_x/models/module_model.dart';

class CourseModel {
  final String Id;
  final String Title;
  final String Description;
  final String Image;
  final String CategoryId;
  final int Current;
  final int Max;
  final List<ModuleModel> Modules;

  CourseModel({
    required this.Id,
    required this.Title,
    required this.Description,
    required this.Image,
    required this.CategoryId,
    required this.Current,
    required this.Max,
    required this.Modules,
  });

  factory CourseModel.fromJson(Map<String, dynamic> rawJson) {
    return CourseModel(
      Id: rawJson["course_id"],
      Title: rawJson["course_name"],
      Description: rawJson["course_description"],
      Image: rawJson["course_image"],
      CategoryId: rawJson["category_id"],
      Current: rawJson["current"],
      Max: rawJson["max"],
      Modules: ModuleModel.toList(rawJson["modules"]),
    );
  }

  static List<CourseModel> toList(List<Map<String, dynamic>>? rawItems) {
    if (rawItems == null) {
      return [];
    }

    List<CourseModel> items = [];
    for (int i = 0; i < rawItems.length; i++) {
      items.add(CourseModel.fromJson(rawItems[i]));
    }

    return items;
  }
}