import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:timer/resources/strings_manager.dart';

void main() {
  runApp(const MyApp());
}

const int maxSeconds = 60;
int seconds = maxSeconds;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 212, 228, 255),
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  Timer? timer;
  late AnimationController animationController;
  void startTimer() {
    timer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      if (seconds > 0) {
        setState(() {
          seconds--;
        });
      } else {
        stopTimer(reset: false);
      }
    });
  }

  @override
  void initState() {
    animationController = AnimationController(vsync: this);
    super.initState();
  }

  void stopTimer({bool reset = true}) {
    setState(() {
      timer!.cancel();
    });
  }

  void resetTimer() {
    setState(() {
      seconds = maxSeconds;
      stopTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 53, 104, 64),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 53, 104, 64),
        title: const Text('Timer CountDown'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildTimerCountDown(),
            const SizedBox(
              height: 50,
            ),
            buildButton()
          ],
        ),
      ),
    );
  }

  Widget buildButton() {
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = seconds == maxSeconds || seconds == 0;
    return !isCompleted
        ? Column(
            children: [
              ButtonWidget(
                  text: timer!.isActive
                      ? StringsManager.pause
                      : StringsManager.resume,
                  onClicked: () {
                    if (isRunning) {
                      stopTimer();
                    } else {
                      startTimer();
                    }
                  }),
              const SizedBox(
                height: 20,
              ),
              ButtonWidget(text: StringsManager.cancel, onClicked: resetTimer),
            ],
          )
        : ButtonWidget(
            text: StringsManager.start,
            onClicked: () {
              startTimer();
            },
          );
  }

  Widget buildTimerCountDown() {
    return SizedBox(
      width: 200,
      height: 200,
      child: Stack(
        fit: StackFit.expand,
        children: [
          seconds != 0
              ? CircularProgressIndicator(
                  value: seconds / maxSeconds,
                  strokeWidth: 12,
                  valueColor: const AlwaysStoppedAnimation(Colors.white),
                  backgroundColor: Colors.black,
                )
              : LottieBuilder.asset(
                  StringsManager.lottieAsset,
                  width: 200,
                  height: 200,
                  fit: BoxFit.fill,
                  controller: animationController,
                  onLoaded: (comp) {
                    animationController
                      ..duration = comp.duration
                      ..forward();
                    Timer.periodic(Duration(seconds: 2), (t) {
                      setState(() {
                        seconds = maxSeconds;
                        t.cancel();
                      });
                    });
                  },
                ),
          Center(
            child: Text(
              '${seconds}',
              style: const TextStyle(
                  fontSize: 40,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto'),
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonWidget extends StatefulWidget {
  final String text;
  final VoidCallback onClicked;
  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.black,
        textStyle: const TextStyle(
          fontSize: 20,
          fontFamily: 'Roboto',
        ),
        elevation: 1,
      ),
      onPressed: widget.onClicked,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          widget.text,
        ),
      ),
    );
  }
}
