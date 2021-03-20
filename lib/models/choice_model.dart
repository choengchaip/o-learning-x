// ignore_for_file: non_constant_identifier_names

import 'package:o_learning_x/utils/object_helper.dart';

class ChoiceModel {
  final String ChoiceId;
  final String ChoiceText;

  ChoiceModel({
    required this.ChoiceId,
    required this.ChoiceText,
  });

  factory ChoiceModel.fromJson(Map<String, dynamic> rawJson) {
    return ChoiceModel(
      ChoiceId: rawJson["choice_id"] ?? "",
      ChoiceText: rawJson["choice_text"] ?? "",
    );
  }

  static List<ChoiceModel> fromListJson(List<dynamic>? listRawJson) {
    if (listRawJson == null) {
      return <ChoiceModel>[].toList();
    }

    List<String> rawChoices =
        (ObjectHelper.toMap(listRawJson[0])['choice'] as String)
            .replaceAll('&quot;', '')
            .replaceAll('[', '')
            .replaceAll(']', '')
            .replaceAll(new RegExp(r'\s+'), '')
            .split(',');
    List<ChoiceModel> choices = List<ChoiceModel>.empty(growable: true);

    for (int i = 0; i < rawChoices.length; i++) {
      choices.add(
        ChoiceModel(
          ChoiceId: i.toString(),
          ChoiceText: rawChoices[i],
        ),
      );
    }

    return choices;
  }
}
