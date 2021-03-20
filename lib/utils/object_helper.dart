import 'package:flutter/cupertino.dart';

class ObjectHelper {
  ObjectHelper._();

  static bool isSnapshotStateLoading(AsyncSnapshot<bool> snapshot) {
    if (!snapshot.hasData || snapshot.data == null || snapshot.data == true) {
      return true;
    }

    return false;
  }

  static toMap(dynamic raw) {
    if (raw == null) {
      return null;
    }

    Map<String, dynamic> map = Map<String, dynamic>();

    (raw as Map).forEach((key, value) {
      map[key] = value;
    });

    return map;
  }
}
