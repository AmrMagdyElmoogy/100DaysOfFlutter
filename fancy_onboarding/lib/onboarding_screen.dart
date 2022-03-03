import 'package:fancy_onboarding/get_started.dart';
import 'package:fancy_onboarding/pages/page_1.dart';
import 'package:fancy_onboarding/pages/page_2.dart';
import 'package:fancy_onboarding/pages/page_3.dart';
import 'package:fancy_onboarding/resources/functions.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 251, 251),
      appBar: AppBar(),
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            onPageChanged: (i){
              setState(() {
                index = i;
              });
            },
            children: const [
              Page1(),
              Page2(),
              Page3(),
            ],
          ),
          Container(
            alignment: const Alignment(0, 0.7),
            child: SmoothPageIndicator(
              controller: pageController,
              count: 3,
              effect: const WormEffect(
                dotWidth: 25,
                dotHeight: 5,
                activeDotColor: Colors.black,
              ),
            ),
          ),
          Container(
            alignment: const Alignment(0.7, 0.9),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                fixedSize: const Size(80, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                nextPage(context: context);
              },
              child: Text(
                'Next',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
