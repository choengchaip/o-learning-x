import 'package:flutter/cupertino.dart';
import 'package:o_learning_x/configs/config.dart';
import 'package:o_learning_x/cores/shared_preferences.dart';
import 'package:o_learning_x/models/leader_board_user_model.dart';
import 'package:o_learning_x/repositories/base_repository.dart';
import 'package:o_learning_x/repositories/types.dart';

class LeaderBoardRepository extends BaseDataRepository<LeaderBoardUserModel>{
  final BuildContext buildCtx;
  final IConfig config;
  final IRepositoryOptions options;
  final ISharedPreferences sharedPreferences;

  LeaderBoardRepository({
    required this.buildCtx,
    required this.config,
    required this.options,
    required this.sharedPreferences,
  }) : super(buildCtx, config, options, sharedPreferences);

  @override
  List<LeaderBoardUserModel> transforms(tss) {
    return LeaderBoardUserModel.toList(tss);
  }

  @override
  LeaderBoardUserModel? transform(ts) {
    return LeaderBoardUserModel.fromJson(ts);
  }
}