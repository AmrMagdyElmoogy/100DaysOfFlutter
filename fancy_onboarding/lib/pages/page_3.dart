import 'package:flutter/material.dart';
import 'package:fancy_onboarding/resources/constants.dart';

class Page3 extends StatefulWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Choose your interests',
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(height: 10),
          Text(
            'To make your feed more personalized',
            style: Theme.of(context).textTheme.caption,
          ),
          const SizedBox(
            height: 20,
          ),
          Wrap(
            spacing: 8.0, // gap between adjacent chips
            runSpacing: 4.0, // gap between lines
            children: List.generate(
              ConstantsManager.instruments.length,
              (index) => CardItemChoice(index: index),
            ),
          ),
        ],
      ),
    );
  }
}

class CardItemChoice extends StatefulWidget {
  final int index;

  const CardItemChoice({Key? key, required this.index}) : super(key: key);

  @override
  State<CardItemChoice> createState() => _CardItemChoiceState();
}

class _CardItemChoiceState extends State<CardItemChoice>
    with TickerProviderStateMixin {
  late AnimationController controller;
  bool tapped = false;
  @override
  void initState() {
    ConstantsManager.colorOfContainer = Colors.white;
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      lowerBound: 0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        changeUiForContainer();
        setState(() {
          if (widget.index < 6 && tapped) {
            ConstantsManager.colorOfContainer = ConstantsManager.colors[0];
          } else if (widget.index >= 6 && widget.index < 12 && tapped) {
            ConstantsManager.colorOfContainer = ConstantsManager.colors[1];
          } else if (widget.index >= 12 && widget.index <= 18 && tapped) {
            ConstantsManager.colorOfContainer = ConstantsManager.colors[2];
          } else {
            ConstantsManager.colorOfContainer = Colors.white;
          }
        });
      },
      child: Transform.scale(
        scale: 1 - controller.value,
        child: Container(
          width: 100,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ConstantsManager.colorOfContainer,
          ),
          child: Center(
            child: Text(
              ConstantsManager.instruments[widget.index],
              style: !tapped
                  ? Theme.of(context).textTheme.caption
                  : Theme.of(context).textTheme.caption!.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }

  void changeUiForContainer() {
    tapped ? onTapUp() : onTapDown();
  }

  void onTapDown() {
    controller.forward();
    setState(() {
      //Not Completed
      tapped = true;
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
