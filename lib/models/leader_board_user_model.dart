// ignore_for_file: non_constant_identifier_names

class LeaderBoardUserModel {
  final String Id;
  final String Title;
  final String ImageURL;
  final String Score;

  LeaderBoardUserModel({
    required this.Id,
    required this.Title,
    required this.ImageURL,
    required this.Score,
  });

  factory LeaderBoardUserModel.fromJson(Map<String, dynamic> rawJson) {
    return LeaderBoardUserModel(
        Id: rawJson['user_id'] ?? "",
        Title: rawJson['user_name'] ?? 'No name',
        ImageURL: rawJson['image'] ?? '',
        Score: (rawJson['module_progress_current']?.toString() ?? ""));
  }

  static List<LeaderBoardUserModel> toList(List<Map<String, dynamic>>? rawItems) {
    if (rawItems == null) {
      return [];
    }

    List<LeaderBoardUserModel> items = [];
    for (int i = 0; i < rawItems.length; i++) {
      items.add(LeaderBoardUserModel.fromJson(rawItems[i]));
    }

    return items;
  }
}
