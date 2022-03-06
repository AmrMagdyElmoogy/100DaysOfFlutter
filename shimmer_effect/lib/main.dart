import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> characters = [
    'Post 1',
    'Post 2',
    'Post 3',
    'Post 4',
    'Post 5',
    'Post 6',
    'Post 7',
    'Post 8',
    'Post 9',
    'Post 10',
  ];

  bool enabled = true;

  void _incrementCounter() {
    setState(() {
      enabled = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shimmer Effect'),
      ),
      body: Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.grey[200]!,
        enabled: enabled,
        child: Column(
          children: List.generate(
              characters.length, (index) => Text(characters[index])),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Toogle Shimmer Effect',
        child: const Icon(Icons.remove_red_eye_outlined),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
