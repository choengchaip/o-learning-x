import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:o_learning_x/configs/config.dart';
import 'package:o_learning_x/cores/shared_preferences.dart';
import 'package:o_learning_x/models/about_me_model.dart';
import 'package:o_learning_x/repositories/base_repository.dart';
import 'package:o_learning_x/repositories/types.dart';
import 'package:o_learning_x/utils/requester.dart';

class AuthenticationRepository extends BaseDataRepository {
  final BuildContext buildCtx;
  final IConfig config;
  final IRepositoryOptions options;
  final ISharedPreferences sharedPreferences;

  int currentStar = 0;
  int currentProgress = 0;
  String userId = '';
  String nameText = '';
  String emailText = '';
  String passwordText = '';
  String newPasswordText = '';
  String confirmPasswordText = '';
  String accessToken = '';
  String currentCourseId = '';
  String currentCourseName = '';
  int star = 0;
  int progress = 0;

  AuthenticationRepository({
    required this.buildCtx,
    required this.config,
    required this.options,
    required this.sharedPreferences,
  }) : super(buildCtx, config, options, sharedPreferences);

  bool get isAuth =>
      this.sharedPreferences.getAuthentication()?["token"] != "" ||
      this.sharedPreferences.getAuthentication()?["token"] != null;

  bool get isNotAuth =>
      this.sharedPreferences.getAuthentication()?["token"] == "" ||
      this.sharedPreferences.getAuthentication()?["token"] == null;

  Future fetchMe() async {
    try {
      this.toLoadingStatus();
      late Map<String, dynamic> data;

      Response response = await Requester.get(
          "${this.options.getBaseUrl()}/users/profile",
          headers: this.sharedPreferences.getAuthentication());
      Map<String, dynamic> js = json.decode(utf8.decode(response.bodyBytes));
      data = {"data": js};

      super.setInnerData(data["data"]);
      this.dataSC.add(this.data);

      AboutMeModel me = AboutMeModel.fromJson(data["data"]);
      this.setUserId(me.Id ?? "");
      this.setName(me.Name);
      this.setEmail(me.Email);
      this.setStar(me.Star ?? 0);
      this.setProgress(me.Progress ?? 0);

      this.sharedPreferences.setAuthentication(others: {
        "email": me.Email,
      });
    } catch (e) {
      this.alertError(e);
      this.toErrorStatus(e);
    }
  }

  Future<void> login() async {
    try {
      this.toLoadingStatus();
      late Map<String, dynamic> data;

      Response response =
          await Requester.post("${this.options.getBaseUrl()}/oauth/token", {
        "email": this.emailText,
        "password": this.passwordText,
      });
      String js = json.decode(utf8.decode(response.bodyBytes));
      data = {"data": js};

      super.setInnerData(data["data"]);
      this.dataSC.add(this.data);

      await this.sharedPreferences.setAuthentication(token: data["data"]);

      this.toLoadedStatus();
    } catch (e) {
      this.alertError(e);
      this.toErrorStatus(e);
    }
  }

  Future<void> register({bool isErrorMock: false}) async {
    try {
      this.toLoadingStatus();
      late Map<String, dynamic> data;

      Response response =
          await Requester.post("${this.options.getBaseUrl()}/users", {
        "email": this.emailText,
        "password": this.passwordText,
      });
      String js = json.decode(utf8.decode(response.bodyBytes));
      data = {"data": js};

      super.setInnerData(data["data"]);
      this.dataSC.add(this.data);

      await this.sharedPreferences.setAuthentication(token: data["data"]);

      response = await Requester.put(
          "${this.options.getBaseUrl()}/users/profile", {"name": this.nameText},
          headers: this.sharedPreferences.getAuthentication());

      await this.fetchMe();

      if (this.currentCourseId != '') {
        response = await Requester.post(
            "${this.options.getBaseUrl()}/courses/my",
            {
              "course_id": this.currentCourseId,
              "user_id": this.userId,
            },
            headers: this.sharedPreferences.getAuthentication());
      }

      this.toLoadedStatus();
    } catch (e) {
      this.alertError(e);
      this.toErrorStatus(e);
    }
  }

  Future<void> changePassword() async {
    try {
      this.toLoadingStatus();
      late Map<String, dynamic> data;

      Response response = await Requester.put(
          "${this.options.getBaseUrl()}/users/resetpassword",
          {
            "oldpassword": this.passwordText,
            "newpassword": this.newPasswordText,
          },
          headers: this.sharedPreferences.getAuthentication());
      Map<String, dynamic> js = json.decode(utf8.decode(response.bodyBytes));
      data = {"data": js};

      super.setInnerData(data["data"]);
      this.dataSC.add(this.data);

      this.toLoadedStatus();
    } catch (e) {
      this.alertError(e);
      this.toErrorStatus(e);
    }
  }

  Future<void> logout() async {
    this.toLoadingStatus();
    this.reset();
    this.sharedPreferences.removeAuthentication();
    this.userId = '';
    this.nameText = '';
    this.emailText = '';
    this.passwordText = '';
    this.newPasswordText = '';
    this.confirmPasswordText = '';
    this.accessToken = '';
    this.currentCourseId = '';
    this.currentCourseName = '';
    this.toLoadedStatus();
  }

  void reset() {
    this.nameText = '';
    this.emailText = '';
    this.passwordText = '';
    this.newPasswordText = '';
    this.confirmPasswordText = '';
  }

  void setUserId(String userId) {
    this.userId = userId;
  }

  void setName(String name) {
    this.nameText = name;
  }

  void setEmail(String email) {
    this.emailText = email;
  }

  void setStar(int start) {
    this.star = start;
  }

  void setProgress(int progress) {
    this.progress = progress;
  }

  void setPassword(String password) {
    this.passwordText = password;
  }

  void setNewPassword(String password) {
    this.newPasswordText = password;
  }

  void setConfirmPassword(String password) {
    this.confirmPasswordText = password;
  }

  void setAccessToken(String token) {
    this.accessToken = token;
  }

  void setCourseId(String courseId) {
    this.currentCourseId = courseId;
  }

  void setCourseName(String courseName) {
    this.currentCourseName = courseName;
  }

  @override
  transform(ts) {
    return ts;
  }
}
