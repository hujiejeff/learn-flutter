import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:learn_flutter/page/card_viewport/route_card_view_pager.dart';
import 'package:learn_flutter/page/route_pager_anim_demo.dart';
import 'package:learn_flutter/page/route_flip_clock_demo.dart';
import 'package:learn_flutter/page/route_custom_flow_layout_demo.dart';
import 'package:learn_flutter/page/route_slide_card_demo.dart';
import 'package:learn_flutter/page/route_swipe_demo.dart';
import 'package:learn_flutter/page/viewport_demo/ViewPortDemo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPaintSizeEnabled = true;
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
            Transform.translate(
              offset: Offset(100, 0),
              child: ElevatedButton(
                child: Text('自定义Layout'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return RouteCustomFlowLayoutDemo();
                  }));
                },
              ),
            ),
            ElevatedButton(
              child: Text('飞卡demo'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return  RouteSlideCardDemo();
                }));
              },
            ),
            ElevatedButton(
              child: Text('ViewportDemo'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return  ViewportDemo();
                }));
              },
            ),

            ElevatedButton(
              child: Text('RouteSwipeDemo'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return  RouteSwipeDemo();
                }));
              },
            ),

            ElevatedButton(
              child: Text('RouteCardViewPagerDemo'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return  RouteCardViewPagerDemo();
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
