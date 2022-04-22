import 'package:flutter/material.dart';
import 'package:learn_flutter/page/route_pager_anim_demo.dart';
import 'package:learn_flutter/page/route_flip_clock_demo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const title = "Flutter Demo";
    return MaterialApp(
      showPerformanceOverlay: false,
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(
        title: title,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text('翻页动画demo'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const RoutePagerDemo();
                }));
              },
            ),
            ElevatedButton(
              child: Text('时钟翻页动画'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const RouteFLipClockDemo();
                }));
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
