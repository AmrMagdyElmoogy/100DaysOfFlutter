import 'dart:async';

import 'package:fancy_onboarding/resources/constants.dart';
import 'package:fancy_onboarding/resources/functions.dart';
import 'package:flutter/material.dart';

class Page1 extends StatefulWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What instrument do you play?',
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(height: 10),
          Text(
            'You can change it anytime',
            style: Theme.of(context).textTheme.caption,
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 400,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) => CardItem(
                      index: index,
                    ),
                separatorBuilder: (context, index) => const SizedBox(width: 10),
                itemCount: 5),
          ),
        ],
      ),
    );
  }
}

class CardItem extends StatefulWidget {
  final int index;
  const CardItem({Key? key, required this.index}) : super(key: key);

  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> with TickerProviderStateMixin {
  late AnimationController _animationController;
  bool tapped = false;
  @override
  void initState() {
    _animationController = AnimationController(
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
        scale: 1 - _animationController.value,
        child: Container(
          width: 250,
          height: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromARGB(255, 243, 222, 154),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(ConstantsManager.images[widget.index]),
                fit: BoxFit.cover,
                width: 200,
                height: 200,
              ),
              const SizedBox(
                height: 70,
              ),
              Text(ConstantsManager.names[widget.index],
                  style: Theme.of(context).textTheme.headline6),
            ],
          ),
        ),
      ),
    );
  }

  void onTapDown() {
    _animationController.forward();
    setState(() {
      //Not Completed
      tapped = true;
      Timer.periodic(const Duration(milliseconds: 300), (timer) {
        nextPage();
        timer.cancel();
      });
    });
  }

  void onTapUp() {
    _animationController.reverse();
    setState(() {
      //Not Completed
      tapped = false;
    });
  }
}
