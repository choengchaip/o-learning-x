import 'package:flutter/cupertino.dart';
import 'package:o_learning_x/configs/config.dart';
import 'package:o_learning_x/cores/shared_preferences.dart';
import 'package:o_learning_x/models/discovery_model.dart';
import 'package:o_learning_x/repositories/base_repository.dart';
import 'package:o_learning_x/repositories/types.dart';

class DiscoveryRepository extends BaseDataRepository<DiscoveryModel> {
  final BuildContext buildCtx;
  final IConfig config;
  final IRepositoryOptions options;
  final ISharedPreferences sharedPreferences;

  late List<String> aliases;
  late String courseId;
  late String experience;
  late String timeSpend;
  late List<String> courseItems;

  DiscoveryRepository({
    required this.buildCtx,
    required this.config,
    required this.options,
    required this.sharedPreferences,
  }) : super(buildCtx, config, options, sharedPreferences) {
    this.aliases = List<String>.empty(growable: true);
    this.courseId = "";
    this.experience = "";
    this.timeSpend = "";
    this.courseItems = List<String>.empty(growable: true);
  }

  addAliasToList(String alias) {
    this.aliases.add(alias);
  }

  addCourse(String courseId) {
    this.courseId = courseId;
  }

  addExperience(double experience) {
    switch (experience.toInt()) {
      case 0:
        this.experience=  "beginner";
        break;
      case 50:
        this.experience = "junior";
        break;
      case 100:
        this.experience = "senior";
        break;
      default:
        this.experience = "beginner";
    }
  }

  addGoal(int timeSpend) {
    switch (timeSpend) {
      case 5:
        this.timeSpend = "casual";
        break;
      case 10:
        this.timeSpend = "regular";
        break;
      case 20:
        this.timeSpend = "serious";
        break;
      default:
        this.timeSpend = "casual";
    }
  }

  popAliasFromList() {
    this.aliases.removeLast();
  }

  @override
  List<DiscoveryModel> transforms(tss) {
    return DiscoveryModel.toList(tss);
  }

  @override
  DiscoveryModel? transform(ts) {
    return DiscoveryModel.fromJson(ts);
  }
}
