// ignore_for_file: non_constant_identifier_names

class CategoryModel {
  final String Id;
  final String Title;
  final String? Image;

  CategoryModel({
    required this.Id,
    required this.Title,
    this.Image,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> rawJson) {
    return CategoryModel(
      Id: rawJson["category_id"] ?? "",
      Title: rawJson["category_name"] ?? "",
    );
  }

  static List<CategoryModel> toList(List<dynamic>? rawItems) {
    if (rawItems == null) {
      return [];
    }

    List<CategoryModel> items = [];
    for (int i = 0; i < rawItems.length; i++) {
      items.add(CategoryModel.fromJson(rawItems[i]));
    }

    return items;
  }
}
