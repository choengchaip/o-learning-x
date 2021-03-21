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
    List<CourseModel> ss = List<CourseModel>.empty(growable: true);
    try {
      ss = CourseModel.toList(tss);
      return ss;
    } catch (e) {
      super.alertError(e);
      super.toErrorStatus(e);
      return ss;
    }
  }

  @override
  CourseModel? transform(ts) {
    CourseModel? s;
    try {
      s = CourseModel.fromJson(ts);
      return s;
    } catch (e) {
      print("CourseModel transform error");
      super.alertError(e);
      super.toErrorStatus(e);
      return s;
    }
  }
}
