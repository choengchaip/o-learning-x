import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_learning_x/configs/config.dart';
import 'package:o_learning_x/cores/context.dart';
import 'package:o_learning_x/repositories/page_repository.dart';
import 'package:o_learning_x/styles/colors.dart';
import 'package:o_learning_x/styles/fonts.dart';
import 'package:o_learning_x/widgets/commons/loading_stack.dart';

class WelcomeDiscoveryChoice extends StatefulWidget {
  final IContext context;
  final IConfig config;
  final PageRepository parentPageRepository;
  final PageRepository rootPageRepository;

  WelcomeDiscoveryChoice({
    required this.context,
    required this.config,
    required this.parentPageRepository,
    required this.rootPageRepository,
  });

  @override
  State<StatefulWidget> createState() {
    return _WelcomeDiscoveryChoiceState();
  }
}

class _WelcomeDiscoveryChoiceState extends State<WelcomeDiscoveryChoice> {
  late PageRepository pageRepository;

  @override
  void initState() {
    super.initState();

    this.pageRepository = PageRepository();
    this.pageRepository.initial();

    widget.context.repositories().discoveryRepository().fetch(isMock: true);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: LoadingStack(
        isLoadingSCs: [widget.context.repositories().discoveryRepository().isLoadingSC],
        children: ()=>[
          Column(
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
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 16, bottom: 16),
                  child: ListView.builder(
                    itemCount: widget.context
                        .repositories()
                        .discoveryRepository()
                        .items
                        .length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          widget.context
                              .repositories()
                              .discoveryRepository()
                              .addAliasToList(widget.context
                              .repositories()
                              .discoveryRepository()
                              .items[index]
                              .Alias);
                          widget.parentPageRepository.nextPage();
                        },
                        child: Card(
                          child: Row(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(20),
                                margin: EdgeInsets.only(right: 8),
                                height: 85,
                                width: 85,
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.red, shape: BoxShape.circle)),
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(right: 16),
                                  child: Text(
                                    widget.context.repositories().discoveryRepository().items[index].Title,
                                    style: TextStyle(
                                      fontSize: p,
                                      color: colorSecondaryDark,
                                      fontWeight: fontWeightBold,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      )
    );
  }
}
