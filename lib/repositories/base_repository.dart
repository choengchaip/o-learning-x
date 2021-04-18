// ignore_for_file: close_sinks

import 'dart:async';
import 'dart:convert';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:o_learning_x/configs/config.dart';
import 'package:o_learning_x/cores/shared_preferences.dart';
import 'package:o_learning_x/mocks/courses/courses.dart';
import 'package:o_learning_x/mocks/discoveries/discovery_choices.dart';
import 'package:o_learning_x/repositories/authentication_repository.dart';
import 'package:o_learning_x/repositories/category_repository.dart';
import 'package:o_learning_x/repositories/course_repository.dart';
import 'package:o_learning_x/repositories/discovery_repository.dart';
import 'package:o_learning_x/repositories/leader_board_repository.dart';
import 'package:o_learning_x/repositories/my_course_repository.dart';
import 'package:o_learning_x/repositories/quiz_repository.dart';
import 'package:o_learning_x/repositories/subject_repository.dart';
import 'package:o_learning_x/repositories/types.dart';
import 'package:o_learning_x/utils/requester.dart';
import 'package:o_learning_x/utils/time_helper.dart';
import 'package:rxdart/rxdart.dart';

class BaseDataRepository<T> implements IBaseDataRepository {
  final BuildContext buildCtx;
  final IConfig config;
  final IRepositoryOptions options;
  final ISharedPreferences sharedPreferences;

  bool _isLoading = false;
  bool _isLoaded = false;
  bool _isError = false;
  String _errorMessage = "";
  List<dynamic>? _items;
  dynamic _data;

  late StreamController<bool> _isLoadingSC;
  late StreamController<bool> _isLoadedSC;
  late StreamController<bool> _isErrorSC;
  late StreamController<String> _errorMessageSC;
  late StreamController<List<T>?> _itemsSC;
  late StreamController<T?> _dataSC;

  BaseDataRepository(
    this.buildCtx,
    this.config,
    this.options,
    this.sharedPreferences,
  ) {
    this.initial();
  }

  @override
  bool get isLoading => this._isLoading;

  @override
  bool get isLoaded => this._isLoaded;

  @override
  bool get isError => this._isError;

  @override
  String get errorMessage => this._errorMessage;

  @override
  List<T> get items => this.transforms(this._items);

  @override
  T? get data => this.transform(this._data);

  @override
  StreamController<bool> get isLoadingSC => this._isLoadingSC;

  @override
  StreamController<bool> get isLoadedSC => this._isLoadedSC;

  @override
  StreamController<bool> get isErrorSC => this._isErrorSC;

  @override
  StreamController<String> get errorMessageSC => this._errorMessageSC;

  @override
  StreamController<List<T>?> get itemsSC => this._itemsSC;

  @override
  StreamController<T?> get dataSC => this._dataSC;

  @override
  void toLoadingStatus() {
    this._isLoading = true;
    this._isLoadingSC.add(true);

    this._isLoaded = false;
    this._isLoadedSC.add(false);

    this._isError = false;
    this._isErrorSC.add(false);
  }

  @override
  void toLoadedStatus() {
    this._isLoading = false;
    this._isLoadingSC.add(false);

    this._isLoaded = true;
    this._isLoadedSC.add(true);
  }

  @override
  void toErrorStatus(e) {
    this._isLoading = false;
    this._isLoadingSC.add(false);

    this._isError = true;
    this._isErrorSC.add(true);

    this._errorMessage = e.toString();
    this._errorMessageSC.add(e.toString());

    print("error: ${e.toString()}");
  }

  @override
  List<T> transforms(tss) {
    return List<T>.empty(growable: true);
  }

  @override
  T? transform(ts) {
    return null;
  }

  @override
  Future<void> fetch({Map<String, dynamic>? params, bool isMock: false}) async {
    try {
      this.toLoadingStatus();
      late Map<String, dynamic> data;

      if (params == null) {
        params = {};
      }

      if (isMock) {
        await TimeHelper.sleep();
        data = {"items": this.options.getMockItems()};
      } else {
        Response response = await Requester.get(
          this.options.getBaseUrl(),
          params: params,
          headers: this.sharedPreferences.getAuthentication(),
        );
        List<dynamic> js = json.decode(utf8.decode(response.bodyBytes));
        data = {"items": js};
      }

      this._items = data["items"];
      this.itemsSC.add(this.items);

      this.toLoadedStatus();
    } catch (e) {
      this.alertError(e);
      this.toErrorStatus(e);
    }
  }

  @override
  Future<void> fetchAfterId(String afterId,
      {Map<String, dynamic>? params, bool isMock = false}) async {
    try {
      this.toLoadingStatus();
      late Map<String, dynamic> data;

      if (params == null) {
        params = {};
      }

      if (isMock) {
        await TimeHelper.sleep();
        data = {"items": this.options.getMockItems()?.sublist(0, 6)};
      } else {
        Response response = await Requester.get(
          this.options.getBaseUrl(),
          params: params,
          headers: this.sharedPreferences.getAuthentication(),
        );
        List<dynamic> js = json.decode(utf8.decode(response.bodyBytes));
        data = {"items": js};
      }

      this._items = [
        ...(this._items ?? []),
        ...(data["items"] ?? []),
      ];
      this.itemsSC.add(this.items);

      this.toLoadedStatus();
    } catch (e) {
      this.alertError(e);
      this.toErrorStatus(e);
    }
  }

  @override
  Future<void> get(String id,
      {Map<String, dynamic>? params, bool isMock: false}) async {
    try {
      this.toLoadingStatus();
      late Map<String, dynamic> data;

      if (params == null) {
        params = {};
      }

      if (isMock) {
        await TimeHelper.sleep();
        Map<String, dynamic> mock = this
            .options
            .getMockItems()!
            .firstWhere((element) => id == element["product_id"]);
        data = {"data": mock};
      } else {
        Response response = await Requester.get(
          "${this.options.getFindUrl() ?? this.options.getBaseUrl()}"
              .replaceFirst(":id", id),
          params: params,
          headers: this.sharedPreferences.getAuthentication(),
        );
        Map<String, dynamic> js = json.decode(utf8.decode(response.bodyBytes));
        data = {"data": js};
      }

      this._data = data["data"];
      this.dataSC.add(this.data);

      this.toLoadedStatus();
    } catch (e) {
      this.alertError(e);
      this.toErrorStatus(e);
    }
  }

  @override
  Future<void> add(
      {required Map<String, dynamic> payload, bool isMock = false}) async {
    try {
      this.toLoadingStatus();
      late Map<String, dynamic> data;

      if (isMock) {
        await TimeHelper.sleep();
        data = {"data": this.options.getMockItem()};
      } else {
        Response response = await Requester.post(
          this.options.getAddUrl() ?? this.options.getBaseUrl(),
          payload,
          headers: this.sharedPreferences.getAuthentication(),
        );
        Map<String, dynamic> js = json.decode(utf8.decode(response.bodyBytes));
        data = {"data": js};
      }

      this._data = data["data"];
      this.dataSC.add(this.data);

      this.toLoadedStatus();
    } catch (e) {
      this.alertError(e);
      this.toErrorStatus(e);
    }
  }

  @override
  Future<void> update(String id,
      {required Map<String, dynamic> payload, bool isMock = false}) async {
    try {
      this.toLoadingStatus();
      late Map<String, dynamic> data;

      if (isMock) {
        await TimeHelper.sleep();
        data = {"data": this.options.getMockItem()};
      } else {
        Response response = await Requester.put(
          this.options.getUpdateUrl() ?? this.options.getBaseUrl(),
          payload,
          headers: this.sharedPreferences.getAuthentication(),
        );
        Map<String, dynamic> js = json.decode(utf8.decode(response.bodyBytes));
        data = {"data": js};
      }

      this._data = data["data"];
      this.dataSC.add(this.data);

      this.toLoadedStatus();
    } catch (e) {
      this.alertError(e);
      this.toErrorStatus(e);
    }
  }

  @override
  Future<void> delete(String id, {bool isMock = false}) async {
    try {
      this.toLoadingStatus();
      late Map<String, dynamic> data;

      if (isMock) {
        await TimeHelper.sleep();
        data = {"data": this.options.getMockItem()};
      } else {
        Response response = await Requester.delete(
          this.options.getDeleteUrl() ?? this.options.getBaseUrl(),
          headers: this.sharedPreferences.getAuthentication(),
        );
        Map<String, dynamic> js = json.decode(utf8.decode(response.bodyBytes));
        data = {"data": js};
      }

      this._data = data["data"];
      this.dataSC.add(this.data);

      this.toLoadedStatus();
    } catch (e) {
      this.alertError(e);
      this.toErrorStatus(e);
    }
  }

  @override
  void forceValueNotify() {
    this._isLoading = !this._isLoading;
    this._isLoadingSC.add(this._isLoading);
    this._isLoading = !this._isLoading;
    this._isLoadingSC.add(this._isLoading);
  }

  @override
  void setInnerData(data) {
    return this._data = data;
  }

  @override
  void setInnerItems(items) {
    return this._items = items;
  }

  @override
  void initial() {
    this._isLoadingSC = BehaviorSubject<bool>();
    this._isLoadedSC = BehaviorSubject<bool>();
    this._isErrorSC = BehaviorSubject<bool>();
    this._errorMessageSC = BehaviorSubject<String>();

    this._itemsSC = BehaviorSubject<List<T>?>();
    this._dataSC = BehaviorSubject<T?>();
  }

  @override
  void dispose() {
    this._isLoadingSC.close();
    this._isLoadedSC.close();
    this._isErrorSC.close();
    this._errorMessageSC.close();
  }

  @override
  void alertError(dynamic e) {
    String title = "Error";
    dynamic message = e;

    if (e is Map && message is Map) {
      title = e["code"] ?? "Error";
      message = e["message"] ?? e;
    }

    Flushbar(
      title: title,
      message: message.toString(),
      duration: Duration(seconds: 3),
      flushbarStyle: FlushbarStyle.GROUNDED,
    )..show(this.buildCtx);
  }
}

class BaseUIRepository implements IBaseUIRepository {
  bool _isLoading = false;
  bool _isLoaded = false;
  bool _isError = false;
  String _errorMessage = "";

  late StreamController<bool> _isLoadingSC;
  late StreamController<bool> _isLoadedSC;
  late StreamController<bool> _isErrorSC;
  late StreamController<String> _errorMessageSC;

  BaseUIRepository() {
    this._isLoadingSC = StreamController<bool>();
    this._isLoadedSC = StreamController<bool>();
    this._isErrorSC = StreamController<bool>();
    this._errorMessageSC = StreamController<String>();
  }

  @override
  bool get isLoading => this._isLoading;

  @override
  bool get isLoaded => this._isLoaded;

  @override
  bool get isError => this._isError;

  @override
  String get errorMessage => this._errorMessage;

  @override
  StreamController<bool> get isLoadingSC => this._isLoadingSC;

  @override
  StreamController<bool> get isLoadedSC => this._isLoadedSC;

  @override
  StreamController<bool> get isErrorSC => this._isErrorSC;

  @override
  StreamController<String> get errorMessageSC => this._errorMessageSC;

  @override
  void toLoadingStatus() {
    this._isLoading = true;
    this._isLoadingSC.add(true);

    this._isLoaded = false;
    this._isLoadedSC.add(false);

    this._isError = false;
    this._isErrorSC.add(false);
  }

  @override
  void toLoadedStatus() {
    this._isLoading = false;
    this._isLoadingSC.add(false);

    this._isLoaded = true;
    this._isLoadedSC.add(true);
  }

  @override
  void toErrorStatus(e) {
    this._isLoading = false;
    this._isLoadingSC.add(false);

    this._isError = true;
    this._isErrorSC.add(true);

    this._errorMessage = e.toString();
    this._errorMessageSC.add(e.toString());

    print("error: ${e.toString()}");
  }

  @override
  void dispose() {
    this._isLoadingSC.close();
    this._isLoadedSC.close();
    this._isErrorSC.close();
    this._errorMessageSC.close();
  }
}

class NewRepository implements IRepositories {
  final BuildContext buildCtx;
  final IConfig config;
  final ISharedPreferences sharedPreferences;

  AuthenticationRepository? _authenticationRepository;
  CategoryRepository? _categoryRepository;
  CourseRepository? _courseRepository;
  DiscoveryRepository? _discoveryRepository;
  LeaderBoardRepository? _leaderBoardRepository;
  MyCourseRepository? _myCourseRepository;
  QuizRepository? _quizRepository;
  SubjectRepository? _subjectRepository;

  NewRepository({
    required this.buildCtx,
    required this.config,
    required this.sharedPreferences,
  });

  @override
  AuthenticationRepository authenticationRepository() {
    if (this._authenticationRepository == null) {
      this._authenticationRepository = AuthenticationRepository(
        buildCtx: this.buildCtx,
        config: this.config,
        sharedPreferences: this.sharedPreferences,
        options: NewRepositoryOptions(
          baseUrl: "${this.config.baseAPI()}",
        ),
      );
    }
    return this._authenticationRepository!;
  }

  @override
  CategoryRepository categoryRepository() {
    if (this._categoryRepository == null) {
      this._categoryRepository = CategoryRepository(
        buildCtx: this.buildCtx,
        config: this.config,
        sharedPreferences: this.sharedPreferences,
        options: NewRepositoryOptions(
          baseUrl: "${this.config.baseAPI()}/category",
        ),
      );
    }
    return this._categoryRepository!;
  }

  @override
  CourseRepository courseRepository() {
    if (this._courseRepository == null) {
      this._courseRepository = CourseRepository(
        buildCtx: this.buildCtx,
        config: this.config,
        sharedPreferences: this.sharedPreferences,
        options: NewRepositoryOptions(
          baseUrl: "${this.config.baseAPI()}/courses",
          mockItems: mockCourses,
        ),
      );
    }
    return this._courseRepository!;
  }

  @override
  DiscoveryRepository discoveryRepository() {
    if (this._discoveryRepository == null) {
      this._discoveryRepository = DiscoveryRepository(
        buildCtx: this.buildCtx,
        config: this.config,
        sharedPreferences: this.sharedPreferences,
        options: NewRepositoryOptions(
          baseUrl: "",
          mockItems: mockDiscoveries,
        ),
      );
    }
    return this._discoveryRepository!;
  }

  @override
  LeaderBoardRepository leaderBoardRepository() {
    if (this._leaderBoardRepository == null) {
      this._leaderBoardRepository = LeaderBoardRepository(
        buildCtx: this.buildCtx,
        config: this.config,
        sharedPreferences: this.sharedPreferences,
        options: NewRepositoryOptions(
          baseUrl: "${this.config.baseAPI()}/leaderboard",
        ),
      );
    }
    return this._leaderBoardRepository!;
  }

  @override
  MyCourseRepository myCourseRepository() {
    if (this._myCourseRepository == null) {
      this._myCourseRepository = MyCourseRepository(
        buildCtx: this.buildCtx,
        config: this.config,
        sharedPreferences: this.sharedPreferences,
        options: NewRepositoryOptions(
          baseUrl: "${this.config.baseAPI()}/courses/my",
          findUrl: "${this.config.baseAPI()}/courses/my/:id",
        ),
      );
    }
    return this._myCourseRepository!;
  }

  @override
  QuizRepository quizRepository() {
    if (this._quizRepository == null) {
      this._quizRepository = QuizRepository(
        buildCtx: this.buildCtx,
        config: this.config,
        sharedPreferences: this.sharedPreferences,
        options: NewRepositoryOptions(
          baseUrl: "${this.config.baseAPI()}",
        ),
      );
    }
    return this._quizRepository!;
  }

  @override
  SubjectRepository subjectRepository() {
    if (this._subjectRepository == null) {
      this._subjectRepository = SubjectRepository(
        buildCtx: this.buildCtx,
        config: this.config,
        sharedPreferences: this.sharedPreferences,
        options: NewRepositoryOptions(
          baseUrl: "${this.config.baseAPI()}",
        ),
      );
    }
    return this._subjectRepository!;
  }
}

class NewRepositoryOptions implements IRepositoryOptions {
  final String baseUrl;
  final String? findUrl;
  final String? addUrl;
  final String? updateUrl;
  final String? deleteUrl;
  final List<Map<String, dynamic>>? mockItems;
  final Map<String, dynamic>? mockItem;

  NewRepositoryOptions({
    required this.baseUrl,
    this.findUrl,
    this.addUrl,
    this.updateUrl,
    this.deleteUrl,
    this.mockItems,
    this.mockItem,
  });

  @override
  String getBaseUrl() {
    return this.baseUrl;
  }

  @override
  String? getFindUrl() {
    return this.findUrl;
  }

  @override
  String? getAddUrl() {
    return this.addUrl;
  }

  @override
  String? getUpdateUrl() {
    return this.updateUrl;
  }

  @override
  String? getDeleteUrl() {
    return this.deleteUrl;
  }

  @override
  List<Map<String, dynamic>>? getMockItems() {
    return this.mockItems;
  }

  @override
  Map<String, dynamic>? getMockItem() {
    return this.mockItem;
  }
}
