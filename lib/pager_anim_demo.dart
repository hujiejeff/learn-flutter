import 'dart:math';
import 'package:flutter/material.dart';


/// 翻书效果
class PagerDemo extends StatefulWidget {
  PagerDemo({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PagerDemoState();
  }
}

class _PagerDemoState extends State<PagerDemo>
    with SingleTickerProviderStateMixin {
  var child1;
  var child2;
  var _child1;
  var _child2;
  var _child3;
  var _child4;

  var _controller;
  var _animation;
  var _animation1;

  @override
  void initState() {
    init();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5))
          ..addListener(() {
            setState(() {});
          });
    _animation = Tween(begin: .0, end: pi / 2).animate(
        CurvedAnimation(parent: _controller, curve: const Interval(.0, .5)));
    _animation1 = Tween(begin: -pi / 2, end: 0.0).animate(
        CurvedAnimation(parent: _controller, curve: const Interval(.5, 1.0)));
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              _child1,
              Transform(
                alignment: Alignment.centerRight,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(_animation1.value),
                child: _child3,
              ),
            ],
          ),
          Container(
            width: 3,
            color: Colors.white,
          ),
          Stack(
            children: [
              _child4,
              Transform(
                alignment: Alignment.centerLeft,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(_animation.value),
                child: _child2,
              )
            ],
          )
        ],
      ),
    );
  }

  init() {
    child1 = Container(
      width: 300,
      height: 400,
      child: Image.asset(
        'images/img_1.png',
        fit: BoxFit.cover,
      ),
    );

    child2 = Container(
        width: 300,
        height: 400,
        child: Image.asset(
          'images/img_2.png',
          fit: BoxFit.cover,
        ));

    _child1 = ClipRect(
      child: Align(
        alignment: Alignment.centerLeft,
        widthFactor: 0.5,
        child: child1,
      ),
    );
    _child2 = ClipRect(
      child: Align(
        alignment: Alignment.centerRight,
        widthFactor: 0.5,
        child: child1,
      ),
    );

    _child3 = ClipRect(
      child: Align(
        alignment: Alignment.centerLeft,
        widthFactor: 0.5,
        child: child2,
      ),
    );

    _child4 = ClipRect(
      child: Align(
        alignment: Alignment.centerRight,
        widthFactor: 0.5,
        child: child2,
      ),
    );
  }
}
