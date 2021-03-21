import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:o_learning_x/configs/config.dart';
import 'package:o_learning_x/cores/constants.dart';
import 'package:o_learning_x/cores/context.dart';
import 'package:o_learning_x/models/discovery_goal_item.dart';
import 'package:o_learning_x/repositories/page_repository.dart';
import 'package:o_learning_x/styles/colors.dart';
import 'package:o_learning_x/styles/fonts.dart';
import 'package:o_learning_x/widgets/commons/curve_button.dart';
import 'package:o_learning_x/widgets/commons/loading_stack.dart';
import 'package:o_learning_x/widgets/commons/radio_button.dart';
import 'package:o_learning_x/widgets/courses/course_item.dart';

class WelcomeDiscoveryNotification extends StatefulWidget {
  final IContext context;
  final IConfig config;
  final PageRepository parentPageRepository;
  final PageRepository rootPageRepository;

  WelcomeDiscoveryNotification({
    required this.context,
    required this.config,
    required this.parentPageRepository,
    required this.rootPageRepository,
  });

  @override
  State<StatefulWidget> createState() {
    return _WelcomeDiscoveryNotificationState();
  }
}

class _WelcomeDiscoveryNotificationState
    extends State<WelcomeDiscoveryNotification> {
  late DateTime dateTime;

  @override
  void initState() {
    super.initState();

    dateTime = DateTime.now();
  }

  void proceed() {
    // pageLauncher(AuthenticationPage(), context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: LoadingStack(
        isLoadingSCs: [],
        children: () => [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(top: 24, bottom: 8),
                child: Text(
                  "header",
                  style: TextStyle(
                    color: colorPrimary,
                    fontSize: p,
                    fontWeight: fontWeightBold,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 8, bottom: 32, left: 8, right: 8),
                child: Text(
                  "title",
                  style: TextStyle(
                    color: colorSecondaryDark,
                    fontSize: h3,
                    fontWeight: fontWeightBold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 16, bottom: 16),
                        height: 175,
                        child: Image.asset(
                            'lib/statics/discovery_notification.png'),
                      ),
                      Container(
                        child: Text(
                          "note",
                          style: TextStyle(
                            fontSize: p,
                            color: colorGray,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          DatePicker.showTimePicker(
                            context,
                            showSecondsColumn: false,
                            locale: widget.config.defaultLanguage(),
                            onConfirm: (DateTime dateTime) {
                              this.dateTime = dateTime;
                            },
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 16),
                          padding:
                              EdgeInsets.only(top: 14, bottom: 14, left: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0.0, 1),
                                  blurRadius: 6,
                                  spreadRadius: 1)
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(32)),
                          ),
                          width: 150,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 8),
                                child: Text(
                                  '${dateTime.hour < 10 ? "0${dateTime.hour}" : "${dateTime.hour}: ${dateTime.minute < 10 ? "0${dateTime.minute}" : "${dateTime.minute}"}"}',
                                  style: TextStyle(fontSize: h5),
                                ),
                              ),
                              Container(
                                child: Icon(Icons.keyboard_arrow_down),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              CurveButton(
                title: "enable_notification_button",
                onClick: () {
                  this.proceed();
                  // authRepository.setCourseId(this.discoveryWidgetRepository.courseId);
                  // this.requestNotificationPermission();
                },
              ),
              GestureDetector(
                onTap: () {
                  this.proceed();
                  // authRepository.setCourseId(this.discoveryWidgetRepository.courseId);
                  // this.proceed();
                },
                child: Container(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Text(
                    "not_now",
                    style: TextStyle(
                      fontSize: h4,
                      color: colorGray,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
