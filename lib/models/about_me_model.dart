// ignore_for_file: non_constant_identifier_names

class AboutMeModel {
  final String? Id;
  final String Name;
  final String Email;
  final String? Password;
  final String? Role;
  final String? Phone;
  final String? RememberToken;
  final String? Birthday;
  final String? Gender;
  final String? BloodGroup;
  final String? SchoolId;
  final String? AuthenticationKey;
  final int? Star;
  final int? Progress;

  AboutMeModel({
    this.Id,
    required this.Name,
    required this.Email,
    this.Password,
    this.Role,
    this.Phone,
    this.RememberToken,
    this.Birthday,
    this.Gender,
    this.BloodGroup,
    this.SchoolId,
    this.AuthenticationKey,
    this.Star,
    this.Progress,
  });

  factory AboutMeModel.fromJson(Map<String, dynamic>? rawJson) {
    return AboutMeModel(
      Id: rawJson?['id'] ?? "",
      Name: rawJson?['name'] ?? "",
      Email: rawJson?['email'] ?? "",
      Password: rawJson?['password'] ?? "",
      Role: rawJson?['role'] ?? "",
      Phone: rawJson?['phone'] ?? "",
      RememberToken: rawJson?['remember_token'] ?? "",
      Birthday: rawJson?['birthday'] ?? "",
      Gender: rawJson?['gender'] ?? "",
      BloodGroup: rawJson?['blood_group'] ?? "",
      SchoolId: rawJson?['school_id'] ?? "",
      AuthenticationKey: rawJson?['authentication_key'] ?? "",
      Star: rawJson?['star'] ?? 0,
      Progress: rawJson?['progress'] ?? 0,
    );
  }

  static List<AboutMeModel> toList(List<Map<String, dynamic>>? rawItems) {
    if (rawItems == null) {
      return [];
    }

    List<AboutMeModel> items = [];
    for (int i = 0; i < rawItems.length; i++) {
      items.add(AboutMeModel.fromJson(rawItems[i]));
    }

    return items;
  }
}
