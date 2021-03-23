import 'package:flutter/cupertino.dart';
import 'package:o_learning_x/configs/config.dart';
import 'package:o_learning_x/cores/shared_preferences.dart';
import 'package:o_learning_x/models/category_model.dart';
import 'package:o_learning_x/repositories/base_repository.dart';
import 'package:o_learning_x/repositories/types.dart';

class CategoryRepository extends BaseDataRepository<CategoryModel> {
  final BuildContext buildCtx;
  final IConfig config;
  final IRepositoryOptions options;
  final ISharedPreferences sharedPreferences;

  CategoryRepository({
    required this.buildCtx,
    required this.config,
    required this.options,
    required this.sharedPreferences,
  }) : super(buildCtx, config, options, sharedPreferences);


  @override
  List<CategoryModel> transforms(tss) {
    return CategoryModel.toList(tss);
  }

  @override
  CategoryModel? transform(ts) {
    return CategoryModel.fromJson(ts);
  }
}
