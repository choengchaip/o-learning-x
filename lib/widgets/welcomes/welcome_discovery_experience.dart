import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_learning_x/configs/config.dart';
import 'package:o_learning_x/cores/context.dart';
import 'package:o_learning_x/repositories/page_repository.dart';
import 'package:o_learning_x/styles/colors.dart';
import 'package:o_learning_x/styles/fonts.dart';
import 'package:o_learning_x/widgets/commons/curve_button.dart';

class WelcomeDiscoveryExperience extends StatefulWidget {
  final IContext context;
  final IConfig config;
  final PageRepository parentPageRepository;
  final PageRepository rootPageRepository;

  WelcomeDiscoveryExperience({
    required this.context,
    required this.config,
    required this.parentPageRepository,
    required this.rootPageRepository,
  });

  @override
  State<StatefulWidget> createState() {
    return _WelcomeDiscoveryExperienceState();
  }
}

class _WelcomeDiscoveryExperienceState
    extends State<WelcomeDiscoveryExperience> {
  late StreamController<double> experienceValueSC;
  late double experienceValue;

  @override
  void initState() {
    super.initState();

    this.experienceValue = 0;
    this.experienceValueSC = StreamController<double>();
    this.experienceValueSC.add(this.experienceValue);
  }

  void updateExperienceValue(double value) {
    this.experienceValue = value;
    this.experienceValueSC.add(this.experienceValue);
  }

  @override
  void dispose() {
    this.experienceValueSC.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(top: 24, bottom: 8),
            child: Text(
              widget.context.localeRepository().getString("discovery_list_header"),
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
              widget.context.localeRepository().getString("discovery_list_title"),
              style: TextStyle(
                color: colorSecondaryDark,
                fontSize: h3,
                fontWeight: fontWeightBold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Spacer(),
          StreamBuilder(
            stream: this.experienceValueSC.stream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }

              return Column(
                children: [
                  Container(
                    height: 300,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          bottom: 100,
                          left: 175,
                          child: AnimatedOpacity(
                            opacity: snapshot.data == 100 ? 1 : 0,
                            duration: Duration(milliseconds: 250),
                            child: Container(
                              width: 150,
                              child: Image.asset(
                                  'lib/statics/experience_book_a_lot.png'),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 90,
                          left: 25,
                          child: AnimatedOpacity(
                            opacity: snapshot.data >= 50 ? 1 : 0,
                            duration: Duration(milliseconds: 250),
                            child: Container(
                              width: 150,
                              child: Image.asset(
                                  'lib/statics/experience_book_little.png'),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 40,
                          left: 100,
                          child: AnimatedOpacity(
                            opacity: 1,
                            duration: Duration(milliseconds: 250),
                            child: Container(
                              width: 200,
                              child: Image.asset(
                                  'lib/statics/experience_book_base.png'),
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
                        Expanded(
                          child: AnimatedOpacity(
                            opacity: (snapshot.data >= 0 && snapshot.data < 49)
                                ? 1
                                : 0.25,
                            duration: Duration(milliseconds: 250),
                            child: Container(
                              child: Text(
                                widget.context.localeRepository().getString("discovery_list_experience_none"),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: h4,
                                  fontWeight: fontWeightBold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: AnimatedOpacity(
                            opacity: (snapshot.data >= 50 && snapshot.data < 100)
                                ? 1
                                : 0.25,
                            duration: Duration(milliseconds: 250),
                            child: Container(
                              child: Text(
                                widget.context.localeRepository().getString("discovery_list_experience_little"),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: h4,
                                  fontWeight: fontWeightBold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: AnimatedOpacity(
                            opacity: snapshot.data == 100 ? 1 : 0.25,
                            duration: Duration(milliseconds: 250),
                            child: Container(
                              child: Text(
                                widget.context.localeRepository().getString("discovery_list_experience_a_lot"),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: h4,
                                  fontWeight: fontWeightBold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: CupertinoSlider(
                            min: 0,
                            max: 100,
                            divisions: 100,
                            activeColor: colorGray,
                            thumbColor: colorPrimary,
                            onChangeEnd: (double value) {
                              double newValue = value / 25;
                              if (newValue <= 1) {
                                this.updateExperienceValue(0);
                              } else if (newValue > 2.75) {
                                this.updateExperienceValue(100);
                              } else {
                                this.updateExperienceValue(50);
                              }
                            },
                            onChanged: (double value) {
                              this.updateExperienceValue(value);
                            },
                            value: snapshot.data,
                          ),
                        ),
                        Container(
                          child: Stack(
                            children: [
                              AnimatedOpacity(
                                opacity: snapshot.data >= 100 ? 1 : 0,
                                duration: Duration(milliseconds: 250),
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    widget.context.localeRepository().getString("discovery_list_experience_a_lot_description"),
                                    style: TextStyle(
                                      fontSize: p,
                                      color: colorGray,
                                    ),
                                  ),
                                ),
                              ),
                              AnimatedOpacity(
                                opacity:
                                    (snapshot.data >= 50 && snapshot.data < 100)
                                        ? 1
                                        : 0,
                                duration: Duration(milliseconds: 250),
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    widget.context.localeRepository().getString("discovery_list_experience_little_description"),
                                    style: TextStyle(
                                      fontSize: p,
                                      color: colorGray,
                                    ),
                                  ),
                                ),
                              ),
                              AnimatedOpacity(
                                opacity:
                                    (snapshot.data >= 0 && snapshot.data < 49)
                                        ? 1
                                        : 0,
                                duration: Duration(milliseconds: 250),
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    widget.context.localeRepository().getString("discovery_list_experience_none_description"),
                                    style: TextStyle(
                                      fontSize: p,
                                      color: colorGray,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          CurveButton(
            title: widget.context.localeRepository().getString("discovery_list_continue_button"),
            onClick: () {
              widget.context
                  .repositories()
                  .discoveryRepository()
                  .addExperience(this.experienceValue);
              widget.parentPageRepository.nextPage();
            },
          ),
        ],
      ),
    );
  }
}
