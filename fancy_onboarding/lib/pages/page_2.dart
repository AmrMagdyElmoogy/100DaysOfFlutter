import 'dart:async';

import 'package:fancy_onboarding/resources/constants.dart';
import 'package:fancy_onboarding/resources/functions.dart';
import 'package:flutter/material.dart';

class Page2 extends StatefulWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What is your level?',
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(height: 10),
          Text(
            'We will adopt the app to your level',
            style: Theme.of(context).textTheme.caption,
          ),
          const SizedBox(
            height: 20,
          ),
          ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) => CardItemLevel(
                    index: index,
                  ),
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemCount: 3),
        ],
      ),
    );
  }
}

class CardItemLevel extends StatefulWidget {
  final int index;
  const CardItemLevel({Key? key, required this.index}) : super(key: key);

  @override
  State<CardItemLevel> createState() => _CardItemLevelState();
}

class _CardItemLevelState extends State<CardItemLevel>
    with TickerProviderStateMixin {
  late AnimationController controller;
  bool tapped = false;
  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      lowerBound: 0,
      upperBound: 0.1,
      duration: const Duration(milliseconds: 200),
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tapped ? onTapUp : onTapDown,
      child: Transform.scale(
        scale: 1 - controller.value,
        child: Container(
          width: 400,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: ConstantsManager.colors[widget.index],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(ConstantsManager.labels[widget.index],
                  style: Theme.of(context).textTheme.headline6),
              const SizedBox(
                height: 10,
              ),
              Text(ConstantsManager.descriptions[widget.index],
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(color: Colors.black)),
            ],
          ),
        ),
      ),
    );
  }

  void onTapDown() {
    controller.forward();
    setState(() {
      //Not Completed
      tapped = true;
    });
    Timer.periodic(const Duration(milliseconds: 300), (timer) {
      nextPage();
      timer.cancel();
    });
  }

  void onTapUp() {
    controller.reverse();
    setState(() {
      //Not Completed
      tapped = false;
    });
  }
}
