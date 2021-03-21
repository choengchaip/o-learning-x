// ignore_for_file: non_constant_identifier_names

import 'package:o_learning_x/models/discovery_goal_item.dart';

enum LANGUAGE { TH, EN }

class Locales {
  Locales._();

  static String get home {
    return "home";
  }

  static String get cart {
    return "cart";
  }

  static String get notification {
    return "notification";
  }

  static String get account {
    return "account";
  }

  static String get search_label {
    return "search_label";
  }

  static String get product {
    return "product";
  }

  static String get product_new_arrival {
    return "product_new_arrival";
  }

  static String get product_best_seller {
    return "product_best_seller";
  }

  static String get view_more {
    return "view_more";
  }
}

class Ratio {
  Ratio._();

  static double get ratio32 => 3 / 2;

  static double get ratio43 => 4 / 3;

  static double get ratio78 => 7 / 8;

  static double get ration169 => 16 / 9;
}

List<DiscoveryGoalModel> discoveryGoalItems = [
  DiscoveryGoalModel(
    Minute: 5,
  ),
  DiscoveryGoalModel(
    Minute: 10,
  ),
  DiscoveryGoalModel(
    Minute: 20,
  ),
];
