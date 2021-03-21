// ignore_for_file: non_constant_identifier_names

class DiscoveryModel {
  final String Image;
  final String Title;
  final String Alias;

  DiscoveryModel({
    required this.Image,
    required this.Title,
    required this.Alias,
  });

  factory DiscoveryModel.fromJson(Map<String, dynamic> rawJson) {
    return DiscoveryModel(
      Image: rawJson["image"] ?? "",
      Title: rawJson["title"] ?? "",
      Alias: rawJson["alias"] ?? "",
    );
  }

  static List<DiscoveryModel> toList(List<Map<String, dynamic>>? rawItems) {
    if (rawItems == null) {
      return [];
    }

    List<DiscoveryModel> items = [];
    for (int i = 0; i < rawItems.length; i++) {
      items.add(DiscoveryModel.fromJson(rawItems[i]));
    }

    return items;
  }
}