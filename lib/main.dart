import 'package:flutter/material.dart';
import 'package:o_learning_x/pages/launch_screen.dart';
import 'package:o_learning_x/repositories/page_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LaunchScreen(
        launchScreenRepository: PageRepository(),
      ),
    );
  }
}
