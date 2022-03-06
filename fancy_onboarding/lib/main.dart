import 'package:fancy_onboarding/onboarding_screen.dart';
import 'package:fancy_onboarding/resources/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp()); // status bar color
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: light,
      debugShowCheckedModeBanner: false,
      home: const OnBoardingScreen(),
    );
  }
}
