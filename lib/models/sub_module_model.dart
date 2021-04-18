// ignore_for_file: non_constant_identifier_names

class SubModuleModel {
  final String Id;
  final String Title;
  final String Description;
  final String ModuleId;
  final int Current;
  final int Max;

  SubModuleModel({
    required this.Id,
    required this.Title,
    required this.Description,
    required this.ModuleId,
    required this.Current,
    required this.Max,
  });

  factory SubModuleModel.fromJson(Map<String, dynamic> rawJson) {
    return SubModuleModel(
      Id: rawJson["submodule_id"],
      Title: rawJson["submodule_name"],
      Description: rawJson["submodule_description"],
      ModuleId: rawJson["module_id"],
      Current: rawJson["current"],
      Max: rawJson["max"],
    );
  }

  static List<SubModuleModel> toList(List<dynamic>? rawItems) {
    if (rawItems == null) {
      return [];
    }

    List<SubModuleModel> items = [];
    for (int i = 0; i < rawItems.length; i++) {
      items.add(SubModuleModel.fromJson(rawItems[i]));
    }

    return items;
  }
}
