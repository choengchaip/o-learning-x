import 'package:flutter/cupertino.dart';
import 'package:o_learning_x/configs/config.dart';
import 'package:o_learning_x/cores/context.dart';
import 'package:o_learning_x/repositories/page_repository.dart';
import 'package:o_learning_x/styles/colors.dart';
import 'package:o_learning_x/styles/fonts.dart';
import 'package:o_learning_x/widgets/commons/curve_button.dart';

class WelcomeIntroducePage extends StatefulWidget {
  final IContext context;
  final IConfig config;
  final PageRepository parentPageRepository;

  WelcomeIntroducePage({
    required this.context,
    required this.config,
    required this.parentPageRepository,
  });

  @override
  State<StatefulWidget> createState() {
    return _WelcomeIntroducePageState();
  }
}

class _WelcomeIntroducePageState extends State<WelcomeIntroducePage> {
  late PageRepository pageRepository;

  @override
  void initState() {
    super.initState();

    this.pageRepository = PageRepository();
    this.pageRepository.initial();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        bottom: MediaQuery.of(context).padding.bottom + 16,
        left: 16,
        right: 16,
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 24, bottom: 8),
            child: Text(
              widget.context.localeRepository().getString("discovery_intro_header"),
              style: TextStyle(
                color: colorPrimary,
                fontSize: p,
                fontWeight: fontWeightBold,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Text(
              widget.context.localeRepository().getString("discovery_intro_title"),
              style: TextStyle(
                color: colorSecondaryDark,
                fontSize: h3,
                fontWeight: fontWeightBold,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
            child: Text(
              widget.context.localeRepository().getString("discovery_intro_description"),
              style: TextStyle(
                color: colorGray,
                fontSize: p,
                fontWeight: fontWeightNormal,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(64),
              width: MediaQuery.of(context).size.width,
              child: Container(
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: Image.asset('lib/statics/logo.png'),
              ),
            ),
          ),
          CurveButton(
            title: widget.context.localeRepository().getString("discovery_intro_let_go_button"),
            onClick: () {
              widget.parentPageRepository.nextPage();
            },
          ),
        ],
      ),
    );
  }
}
