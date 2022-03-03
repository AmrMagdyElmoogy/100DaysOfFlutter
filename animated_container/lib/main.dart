import 'package:flutter/material.dart';
import 'dart:async';
import 'package:lottie/lottie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Recipe'),
          ),
          body: const Activity()),
    );
  }
}

class Activity extends StatefulWidget {
  const Activity({Key? key}) : super(key: key);

  @override
  _ActivityState createState() => _ActivityState();
}

class _ActivityState extends State<Activity> with TickerProviderStateMixin {
  double widthPrimaryContainer = 400;
  double heightPrimaryContainer = 350;
  double widthSecondContainer = 160;
  double heightSecondContainer = 80;
  int maxMinutes = 2;
  int seconds = 0;
  int page = 1;
  var play = Icons.play_arrow;
  var pause = Icons.pause;
  var icon = Icons.play_arrow;
  bool ended = false;
  double v = 120;
  late AnimationController lottie;
  @override
  void initState() {
    lottie = AnimationController(vsync: this);
    super.initState();
  }

  Timer? timer;
  void startTimer() {
    timer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      if (seconds == 0 && maxMinutes > 0) {
        setState(() {
          seconds = 60;
          maxMinutes--;
          seconds--;
          v--;
        });
      } else if (seconds <= 60) {
        if (seconds == 0 && maxMinutes == 0) {
          stopTimer(reset: false);
        } else {
          setState(() {
            seconds--;
            v--;
          });
        }
      }
    });
  }

  void stopTimer({bool reset = true}) {
    setState(() {
      timer!.cancel();
    });
  }

  @override
  void dispose() {
    lottie.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('Suggestion of Today',
              style: Theme.of(context).textTheme.headline6),
          const SizedBox(height: 20),
          const CircleAvatar(
            backgroundColor: Colors.pink,
            radius: 30,
            backgroundImage: AssetImage('assets/images/person.jpg'),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 12),
            child: Text(
              'Chef Paul',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
          ended
              ? Column(
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Step ',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.pink, fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                            text: '${page} ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color: Colors.pink,
                                    fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: 'Of 6',
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      color: Colors.pink,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 40),
                      child: Text(
                        'Rub Salmon with olive oli, then sprinkle with the seasoning',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 150,
                      height: 150,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          CircularProgressIndicator(
                            //here
                            value: v / 120,
                            strokeWidth: 4,
                            valueColor: const AlwaysStoppedAnimation(
                                Color.fromARGB(255, 226, 110, 56)),
                            backgroundColor: Colors.grey,
                          ),
                          Center(
                            child: maxMinutes == 0 && seconds == 0
                                ? Lottie.asset('assets/images/done.json',
                                    controller: lottie, onLoaded: (l) {
                                    lottie
                                      ..duration = l.duration
                                      ..forward();
                                  })
                                : Lottie.asset('assets/images/food.json',
                                    controller: lottie, onLoaded: (l) {
                                    lottie
                                      ..duration = l.duration
                                      ..forward()
                                      ..repeat();
                                  }),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${maxMinutes} : ${seconds}',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.pink,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        border: Border.all(
                          color: const Color.fromARGB(255, 248, 180, 149),
                          width: 10,
                        ),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          if (icon == play) {
                            startTimer();
                            setState(() {
                              icon = pause;
                            });
                          } else {
                            stopTimer();
                            setState(() {
                              icon = play;
                            });
                          }
                        },
                        child: Icon(icon, color: Colors.white, size: 35),
                        style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(255, 226, 110, 56),
                          shape: const CircleBorder(),
                          fixedSize: const Size(66, 66),
                          elevation: 1,
                        ),
                      ),
                    ),
                  ],
                )
              : Container(),
          Visibility(
            visible: ended == true ? false : true,
            child: Stack(
              overflow: Overflow.visible,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    color: Colors.pink,
                    child: Opacity(
                      opacity: 0.8,
                      child: AnimatedContainer(
                        onEnd: () {
                          setState(() {
                            ended = true;
                          });
                        },
                        curve: Curves.easeIn,
                        width: widthPrimaryContainer,
                        height: heightPrimaryContainer,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: const DecorationImage(
                              image: AssetImage('assets/images/salad.jpg'),
                              fit: BoxFit.cover),
                        ),
                        duration: const Duration(seconds: 1),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 250),
                  child: Center(
                    child: Text(
                      'Salmon with Salad',
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  bottom: -30,
                  left: 90,
                  duration: const Duration(seconds: 1),
                  child: Container(
                    width: widthSecondContainer,
                    height: heightSecondContainer,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white,
                    ),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          widthPrimaryContainer = 0;
                          widthSecondContainer = 0;
                          heightPrimaryContainer = 0;
                          heightSecondContainer = 0;
                        });
                      },
                      child: Container(
                        width: 140,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.pink,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.play_arrow,
                                size: 20,
                                color: Colors.white,
                              ),
                              Text(
                                'Let\'s Try',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
