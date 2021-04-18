import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_learning_x/configs/config.dart';
import 'package:o_learning_x/cores/context.dart';
import 'package:o_learning_x/middlewares/scaffold_middle_ware.dart';
import 'package:o_learning_x/pages/launch_screen.dart';
import 'package:o_learning_x/repositories/page_repository.dart';
import 'package:o_learning_x/styles/colors.dart';
import 'package:o_learning_x/styles/fonts.dart';
import 'package:o_learning_x/widgets/commons/curve_button.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ScoreSummaryResult extends StatefulWidget {
  final IContext context;
  final IConfig config;
  final PageRepository parentPageRepository;

  ScoreSummaryResult({
    required this.context,
    required this.config,
    required this.parentPageRepository,
  });

  @override
  State<StatefulWidget> createState() {
    return _ScoreSummaryResult();
  }
}

class _ScoreSummaryResult extends State<ScoreSummaryResult> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    margin: EdgeInsets.only(bottom: 32),
                    height: 300,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: SfRadialGauge(
                      axes: <RadialAxis>[
                        RadialAxis(
                          minimum: 0,
                          maximum: widget.context
                              .repositories()
                              .quizRepository()
                              .receivePoint
                              .toDouble(),
                          showLabels: false,
                          showTicks: false,
                          axisLineStyle: AxisLineStyle(
                            thickness: 0.1,
                            cornerStyle: CornerStyle.bothCurve,
                            color: colorGrayLighter,
                            thicknessUnit: GaugeSizeUnit.factor,
                          ),
                          pointers: <GaugePointer>[
                            RangePointer(
                              value: 73,
                              width: 13,
                              color: Theme.of(context).primaryColorLight,
                              enableAnimation: true,
                              cornerStyle: CornerStyle.bothCurve,
                            ),
                          ],
                          annotations: <GaugeAnnotation>[
                            GaugeAnnotation(
                              angle: 90,
                              widget: Container(
                                child: Text(
                                  widget.context
                                      .repositories()
                                      .quizRepository()
                                      .receivePoint
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 68,
                                  ),
                                ),
                              ),
                              positionFactor: 0,
                            ),
                            GaugeAnnotation(
                              angle: 90,
                              widget: Container(
                                child: Text(
                                  'EARNED TODAY',
                                  style: TextStyle(
                                    fontSize: p,
                                    color: colorGray,
                                  ),
                                ),
                              ),
                              positionFactor: 0.35,
                            ),
                            GaugeAnnotation(
                              angle: 90,
                              widget: Container(
                                child: Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 48,
                                ),
                              ),
                              positionFactor: 0.75,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Text(
                      'Lesson complete!\nReach your daily goal!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: h4,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.only(
              bottom: 16,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(
                  12,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(
                      right: 16,
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          color: colorGrayLighter,
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            bottom: 4,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(
                                  'Correct answers',
                                  style: TextStyle(
                                    fontSize: p,
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  widget.context
                                      .repositories()
                                      .quizRepository()
                                      .receivePoint
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: p,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(
                                  'Level 1 multiplier',
                                  style: TextStyle(
                                    fontSize: p,
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  'x 1',
                                  style: TextStyle(
                                    fontSize: p,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: 16,
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          bottom: 4,
                        ),
                        child: Text(
                          'EARNED',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: p,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                right: 4,
                              ),
                              child: Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                            ),
                            Container(
                              child: Text(
                                widget.context
                                    .repositories()
                                    .quizRepository()
                                    .receivePoint
                                    .toString(),
                                style: TextStyle(
                                  fontSize: h4,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          CurveButton(
            title: 'CONTINUE',
            onClick: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return ScaffoldMiddleWare(
                      context: widget.context,
                      config: widget.config,
                      child: LaunchScreen(
                        launchScreenRepository: PageRepository(),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
