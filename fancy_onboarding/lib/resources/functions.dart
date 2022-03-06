import 'package:flutter/material.dart';

import '../get_started.dart';

int index = 0;
final PageController pageController = PageController();
void nextPage({BuildContext? context}) {
  if(index == 2)
  {
    Navigator.of(context!).push(MaterialPageRoute(builder: (_)=> const GetStarted()));
  }
  pageController.nextPage(
      duration: const Duration(
        milliseconds: 200,
      ),
      curve: Curves.easeIn);
}


