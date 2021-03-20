import 'package:flutter/cupertino.dart';
import 'package:o_learning_x/configs/config.dart';
import 'package:o_learning_x/models/leader_board_user_model.dart';
import 'package:o_learning_x/repositories/base_repository.dart';
import 'package:o_learning_x/repositories/types.dart';

class LeaderBoardRepository extends BaseDataRepository<LeaderBoardUserModel>{
  final BuildContext buildCtx;
  final IConfig config;
  final IRepositoryOptions options;

  LeaderBoardRepository({
    required this.buildCtx,
    required this.config,
    required this.options,
  }) : super(buildCtx, config, options);

  @override
  List<LeaderBoardUserModel> transforms(tss) {
    return LeaderBoardUserModel.toList(tss);
  }

  @override
  LeaderBoardUserModel? transform(ts) {
    return LeaderBoardUserModel.fromJson(ts);
  }
}