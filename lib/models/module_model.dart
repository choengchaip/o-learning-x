// ignore_for_file: non_constant_identifier_names
import 'package:o_learning_x/models/sub_module_model.dart';

class ModuleModel {
  final String Id;
  final String Title;
  final String Description;
  final String Image;
  final String CourseId;
  final List<SubModuleModel> SubModules;

  ModuleModel({
    required this.Id,
    required this.Title,
    required this.Description,
    required this.Image,
    required this.CourseId,
    required this.SubModules,
  });

  factory ModuleModel.fromJson(Map<String, dynamic> rawJson) {
    return ModuleModel(
      Id: rawJson["module_id"],
      Title: rawJson["module_name"],
      Description: rawJson["module_description"],
      Image: rawJson["module_image"],
      CourseId: rawJson["course_id"],
      SubModules: SubModuleModel.toList(rawJson["submodules"]),
    );
  }

  static List<ModuleModel> toList(List<Map<String, dynamic>>? rawItems) {
    if (rawItems == null) {
      return [];
    }

    List<ModuleModel> items = [];
    for (int i = 0; i < rawItems.length; i++) {
      items.add(ModuleModel.fromJson(rawItems[i]));
    }

    return items;
  }
}
