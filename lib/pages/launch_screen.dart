import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_learning_x/configs/config.dart';
import 'package:o_learning_x/cores/context.dart';
import 'package:o_learning_x/features/main_feature.dart';
import 'package:o_learning_x/features/welcome_feature.dart';
import 'package:o_learning_x/middlewares/scaffold_middle_ware.dart';
import 'package:o_learning_x/repositories/page_repository.dart';

class LaunchScreen extends StatefulWidget {
  final BasePageRepository launchScreenRepository;

  LaunchScreen({
    required this.launchScreenRepository,
  });

  @override
  State<LaunchScreen> createState() {
    return LaunchScreenState();
  }
}

class LaunchScreenState extends State<LaunchScreen> {
  late IContext myContext;
  late IConfig config;

  @override
  void initState() {
    super.initState();

    this.config = Config();
    this.myContext = Context(
      buildCtx: this.context,
      config: config,
    );

    widget.launchScreenRepository.initial();
    widget.launchScreenRepository.toLoadingStatus();
    this.initialConfig();
  }

  Future<void> initialConfig() async {
    try {
      await this.config.initial();
      await this.myContext.initial();
      await this.myContext.localeRepository().loadLocale();

      Map<String, dynamic>? user =
          this.myContext.sharedPreferences().getAuthentication();

      if (user == null) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ScaffoldMiddleWare(
              context: this.myContext,
              config: this.config,
              child: WelcomeFeature(
                context: myContext,
                config: config,
              ),
            ),
          ),
        );
      } else {
        this
            .myContext
            .repositories()
            .authenticationRepository()
            .setEmail(user["email"] ?? "");
        this
            .myContext
            .repositories()
            .authenticationRepository()
            .setAccessToken(user["authorization"] ?? "");

        await this
            .myContext
            .repositories()
            .authenticationRepository()
            .fetchMe();
        await this.myContext.repositories().myCourseRepository().fetch();

        if (this.myContext.repositories().myCourseRepository().items.length >
            0) {
          this.myContext.repositories().authenticationRepository().setCourseId(
              this.myContext.repositories().myCourseRepository().items[0].Id);
          this
              .myContext
              .repositories()
              .authenticationRepository()
              .setCourseName(this
                  .myContext
                  .repositories()
                  .myCourseRepository()
                  .items[0]
                  .Title);
        }

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ScaffoldMiddleWare(
              context: this.myContext,
              config: this.config,
              child: MainFeature(
                context: myContext,
                config: config,
              ),
            ),
          ),
        );
      }

      widget.launchScreenRepository.toLoadedStatus();
    } catch (e) {
      widget.launchScreenRepository.toErrorStatus(e);
    }
  }

  @override
  void dispose() {
    widget.launchScreenRepository.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<bool>(
        stream: widget.launchScreenRepository.isLoadingSC.stream,
        builder: (BuildContext context, snapshot) {
          return Center(
            child: Container(
              child: Icon(Icons.favorite),
            ),
          );
        },
      ),
    );
  }
}
