import 'package:flutter/cupertino.dart';
import 'package:o_learning_x/configs/config.dart';
import 'package:o_learning_x/cores/shared_preferences.dart';
import 'package:o_learning_x/repositories/base_repository.dart';
import 'package:o_learning_x/repositories/types.dart';

class SubjectRepository extends BaseDataRepository {
  final BuildContext buildCtx;
  final IConfig config;
  final IRepositoryOptions options;
  final ISharedPreferences sharedPreferences;

  late String categoryName;

  SubjectRepository({
    required this.buildCtx,
    required this.config,
    required this.options,
    required this.sharedPreferences,
  }) : super(buildCtx, config, options, sharedPreferences){
    this.categoryName = "";
  }

  setCategoryName(String name) {
    this.categoryName = name;
  }
}
