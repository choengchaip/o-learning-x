import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

class WelcomeDiscoveryGoal extends StatefulWidget {
  final IContext context;
  final IConfig config;
  final PageRepository parentPageRepository;
  final PageRepository rootPageRepository;

  WelcomeDiscoveryGoal({
    required this.context,
    required this.config,
    required this.parentPageRepository,
    required this.rootPageRepository,
  });

  @override
  State<StatefulWidget> createState() {
    return _WelcomeDiscoveryGoalState();
  }
}

class _WelcomeDiscoveryGoalState extends State<WelcomeDiscoveryGoal> {
  late int timeSpend;

  @override
  void initState() {
    super.initState();

    this.timeSpend = 5;
  }

  List<DiscoveryGoalModel> get goalItems {
    return discoveryGoalItems.map((DiscoveryGoalModel obj) {
      String name = '';

      if (obj.Minute == 5) {
        name = "casual";
      } else if (obj.Minute == 10) {
        name = "regular";
      } else if (obj.Minute == 20) {
        name = "serious";
      }

      return DiscoveryGoalModel(
          Name: name, Minute: obj.Minute, SpendTitle: '${obj.Minute} minute');
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: LoadingStack(
        isLoadingSCs: [
          widget.context.repositories().discoveryRepository().isLoadingSC,
        ],
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
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: ListView(
                    children: [
                      Container(
                        child: Text(
                          "title",
                          style: TextStyle(
                            fontSize: h3,
                            fontWeight: fontWeightBold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        height: 200,
                        child: Image.asset('lib/statics/discovery_goal.png'),
                      ),
                      Container(
                        child: Text(
                          "note",
                          style: TextStyle(
                            fontSize: p,
                            color: colorGray,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(16),
                        child: Card(
                          child: Container(
                            padding: EdgeInsets.only(left: 16, right: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:
                                  List.generate(this.goalItems.length, (index) {
                                return GestureDetector(
                                  onTap: () {
                                    this.timeSpend = this.goalItems[index].Minute;
                                    widget.context.repositories().discoveryRepository().forceValueNotify();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border(
                                            top: BorderSide(
                                                color: index == 0
                                                    ? Colors.white
                                                    : Colors.black12,
                                                width: 1))),
                                    padding:
                                        EdgeInsets.only(top: 16, bottom: 16),
                                    child: Row(
                                      children: [
                                        RadioButton(
                                          margin: EdgeInsets.only(right: 16),
                                          active: this.timeSpend == goalItems[index].Minute,
                                          onClick: () {
                                            this.timeSpend = this.goalItems[index].Minute;
                                            widget.context.repositories().discoveryRepository().forceValueNotify();
                                          },
                                        ),
                                        Container(
                                          child: Text(
                                            goalItems[index].Name ?? "",
                                            style: TextStyle(
                                              fontSize: h5,
                                              fontWeight: fontWeightBold,
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          child: Text(
                                            goalItems[index].SpendTitle ?? "",
                                            style: TextStyle(
                                              fontSize: h5,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              CurveButton(
                title: "continue_button",
                onClick: () {
                  widget.context.repositories().discoveryRepository().addGoal(this.timeSpend);
                  widget.parentPageRepository.nextPage();
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
