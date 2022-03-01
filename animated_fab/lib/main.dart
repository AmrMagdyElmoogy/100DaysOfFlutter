import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

double buttonSize = 50;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      debugShowCheckedModeBanner: false,
      home: const AnimatedFAB(),
    );
  }
}

class AnimatedFAB extends StatelessWidget {
  const AnimatedFAB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Animated FAB',
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Hi, Amr Elmoogy, Welcome Back !',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Roboto',
            fontSize: 20,
          ),
        ),
      ),
      floatingActionButton: const CircleAnimatedFAB(),
    );
  }
}

class CircleAnimatedFAB extends StatefulWidget {
  const CircleAnimatedFAB({Key? key}) : super(key: key);

  @override
  State<CircleAnimatedFAB> createState() => _CircleAnimatedFABState();
}

class _CircleAnimatedFABState extends State<CircleAnimatedFAB>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  @override
  void initState() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: FlowIconsDelegate(controller: controller),
      children: <IconData>[
        Icons.email,
        Icons.record_voice_over,
        Icons.file_copy_sharp,
        Icons.video_call,
        Icons.list,
      ].map(buildFAB).toList(),
    );
  }

  Widget buildFAB(IconData icon) {
    return SizedBox(
      width: buttonSize,
      height: buttonSize,
      child: FloatingActionButton(
        onPressed: () {
          if (controller.status == AnimationStatus.completed) {
            controller.reverse();
            setState(() {
              icon = Icons.menu;
            });
          } else {
            controller.forward();
            setState(() {
              icon = Icons.close;
            });
          }
        },
        child: Icon(
          icon,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}

class FlowIconsDelegate extends FlowDelegate {
  late AnimationController controller;
  FlowIconsDelegate({required this.controller}) : super(repaint: controller);
  @override
  void paintChildren(FlowPaintingContext context) {
    final n = context.childCount;
    final size = context.size;
    final xStart = size.width - buttonSize;
    final yStart = size.height - buttonSize;
    for (int i = 0; i < n; i++) {
      final radius = 180 * controller.value;
      final lastItem = i == n - 1;
      final setValue = (value) => lastItem ? 0 : value;
      final th = i * 3.14 * 0.5 / (n - 2);
      final x = xStart - setValue(radius * cos(th));
      final y = yStart - setValue(radius * sin(th));
      context.paintChild(i,
          transform: Matrix4.identity()
            ..translate(x, y, 0)
            ..translate(buttonSize / 2, buttonSize / 2)
            ..rotateZ(lastItem ? 0 : 180 * (1 - controller.value) * 3.14 / 180)
            ..translate(-buttonSize / 2, -buttonSize / 2));
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    return false;
  }
}
