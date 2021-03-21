import 'package:flutter/cupertino.dart';
import 'package:o_learning_x/configs/config.dart';
import 'package:o_learning_x/cores/context.dart';
import 'package:o_learning_x/pages/base_page.dart';
import 'package:o_learning_x/repositories/page_repository.dart';
import 'package:o_learning_x/styles/colors.dart';
import 'package:o_learning_x/styles/fonts.dart';
import 'package:o_learning_x/widgets/commons/curve_button.dart';
import 'package:o_learning_x/widgets/welcomes/welcome_infomation.dart';

class WelcomeHomePage extends StatefulWidget {
  final IContext context;
  final IConfig config;
  final PageRepository parentPageRepository;

  WelcomeHomePage({
    required this.context,
    required this.config,
    required this.parentPageRepository,
  });

  @override
  State<StatefulWidget> createState() {
    return WelcomeHomePageState();
  }
}

class WelcomeHomePageState extends State<WelcomeHomePage> {
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
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // GestureDetector(
                //   onTap: (){
                //     authRepo.login();
                //     pageLauncher(Index(), context);
                //   },
                //   child: Container(
                //     child: Text(
                //       'คลิกเพื่อข้ามขั้นตอน (ทดสอบ)',
                //       style: TextStyle(
                //         color: Theme.of(context).primaryColor,
                //         fontSize: fontSizeP,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //   ),
                // ),
                GestureDetector(
                  onTap: () {
                    // pageLauncher(MainPage(), context);
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (_) => AuthenticationPage()));
                  },
                  child: Container(
                    child: Text(
                      "login_button",
                      style: TextStyle(
                        color: colorGray,
                        fontSize: p,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: BasePage(
                pageRepository: this.pageRepository,
                widgets: [
                  WelcomeInformation(
                    context: widget.context,
                    config: widget.config,
                    logoImage: 'lib/statics/logo.png',
                    title: "learn_to_code_title",
                    description: "learn_to_code_description",
                  ),
                  WelcomeInformation(
                    context: widget.context,
                    config: widget.config,
                    logoImage: 'lib/statics/logo.png',
                    title: "build_project_title",
                    description: "build_project_description",
                  ),
                  WelcomeInformation(
                    context: widget.context,
                    config: widget.config,
                    logoImage: 'lib/statics/logo.png',
                    title: "learn_to_code_title",
                    description: "learn_to_code_description",
                  ),
                ],
              ),
            ),
          ),
          CurveButton(
            margin: EdgeInsets.only(
              left: 16,
              right: 16,
            ),
            onClick: () {
              if (this.pageRepository.isLastPage) {
                widget.parentPageRepository.nextPage();
              } else {
                this.pageRepository.nextPage();
              }
            },
            title: "get_started_button",
          ),
        ],
      ),
    );
  }
}
