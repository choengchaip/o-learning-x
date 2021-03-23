import 'dart:async';
import 'package:o_learning_x/repositories/authentication_repository.dart';
import 'package:o_learning_x/repositories/category_repository.dart';
import 'package:o_learning_x/repositories/course_repository.dart';
import 'package:o_learning_x/repositories/discovery_repository.dart';
import 'package:o_learning_x/repositories/leader_board_repository.dart';
import 'package:o_learning_x/repositories/my_course_repository.dart';
import 'package:o_learning_x/repositories/quiz_repository.dart';
import 'package:o_learning_x/repositories/subject_repository.dart';

abstract class IRepositories {
  AuthenticationRepository authenticationRepository();

  CategoryRepository categoryRepository();

  CourseRepository courseRepository();

  DiscoveryRepository discoveryRepository();

  LeaderBoardRepository leaderBoardRepository();

  MyCourseRepository myCourseRepository();

  QuizRepository quizRepository();

  SubjectRepository subjectRepository();
}

abstract class IRepositoryOptions {
  String getBaseUrl();

  String? getFindUrl();

  String? getAddUrl();

  String? getUpdateUrl();

  String? getDeleteUrl();

  List<Map<String, dynamic>>? getMockItems();

  Map<String, dynamic>? getMockItem();
}

abstract class IBaseDataRepository<T> {
  bool get isLoading;

  bool get isLoaded;

  bool get isError;

  String get errorMessage;

  List<T>? get items;

  T? get data;

  StreamController<bool> get isLoadingSC;

  StreamController<bool> get isLoadedSC;

  StreamController<bool> get isErrorSC;

  StreamController<String> get errorMessageSC;

  StreamController<List<T>?> get itemsSC;

  StreamController<T?> get dataSC;

  void toLoadingStatus();

  void toLoadedStatus();

  void toErrorStatus(dynamic e);

  List<T>? transforms(dynamic tss);

  T? transform(dynamic ts);

  Future<void> fetch({
    Map<String, dynamic>? params,
    bool isMock: false,
  });

  Future<void> fetchAfterId(
    String afterId, {
    Map<String, dynamic>? params,
    bool isMock: false,
  });

  Future<void> get(
    String id, {
    Map<String, dynamic>? params,
    bool isMock: false,
  });

  Future<void> add({
    required Map<String, dynamic> payload,
    bool isMock: false,
  });

  Future<void> update(
    String id, {
    required Map<String, dynamic> payload,
    bool isMock: false,
  });

  Future<void> delete(
    String id, {
    bool isMock: false,
  });

  void forceValueNotify();

  void setInnerData(dynamic data);

  void initial();

  void dispose();

  void alertError(dynamic e);
}

abstract class IBaseUIRepository<T> {
  bool get isLoading;

  bool get isLoaded;

  bool get isError;

  String get errorMessage;

  StreamController<bool> get isLoadingSC;

  StreamController<bool> get isLoadedSC;

  StreamController<bool> get isErrorSC;

  StreamController<String> get errorMessageSC;

  void toLoadingStatus();

  void toLoadedStatus();

  void toErrorStatus(dynamic e);

  void dispose();
}
