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
      debugShowCheckedModeBanner: false,
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
      body: !enabled
          ? Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: List.generate(
                    characters.length,
                    (index) => Text(
                          characters[index],
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        )),
              ),
            )
          : Shimmer.fromColors(
              baseColor: Colors.grey,
              highlightColor: Colors.grey[200]!,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) => ourBody(),
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 10,
                            ),
                        itemCount: 12)
                  ],
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Toogle Shimmer Effect',
        child: const Icon(Icons.remove_red_eye_outlined),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget ourBody() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 40,
          width: 40,
          color: Colors.grey,
        ),
        const SizedBox(width: 10),
        Container(
          width: 220,
          height: 20,
          color: Colors.grey,
        ),
      ],
    );
  }
}
