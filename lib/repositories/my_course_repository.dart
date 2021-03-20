import 'package:flutter/cupertino.dart';
import 'package:o_learning_x/configs/config.dart';
import 'package:o_learning_x/models/course_model.dart';
import 'package:o_learning_x/repositories/base_repository.dart';
import 'package:o_learning_x/repositories/types.dart';

class MyCourseRepository extends BaseDataRepository<CourseModel> {
  final BuildContext buildCtx;
  final IConfig config;
  final IRepositoryOptions options;

  MyCourseRepository({
    required this.buildCtx,
    required this.config,
    required this.options,
  }) : super(buildCtx, config, options);


  @override
  List<CourseModel> transforms(tss) {
    return CourseModel.toList(tss);
  }

  @override
  CourseModel? transform(ts) {
    return CourseModel.fromJson(ts);
  }
}
