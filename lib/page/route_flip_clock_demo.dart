import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class RouteFLipClockDemo extends StatelessWidget {
  const RouteFLipClockDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(child: FlipClock()),
    );
  }

  Widget buildBody(int num) {
    int next = (num + 1) % 10;
    return FlipContainer(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Container(
            width: 100,
            height: 130,
            alignment: Alignment.center,
            child: Text(
              num.toString(),
              style: const TextStyle(color: Colors.white, fontSize: 100),
            ),
            color: Colors.black,
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Container(
            width: 100,
            height: 130,
            alignment: Alignment.center,
            child: Text(
              next.toString(),
              style: const TextStyle(color: Colors.white, fontSize: 100),
            ),
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

class FlipClock extends StatefulWidget {
  const FlipClock({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FlipClockState();
  }
}

class _FlipClockState extends State<FlipClock> {
  int h = 0;
  int m = 0;
  int s = 0;
  Timer? _timer;
  bool isHourStartAni = false;
  bool isMinuteStartAni = false;
  bool isSecondStartAni = false;

  @override
  Widget build(BuildContext context) {
    print("build" + s.toString());
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildFlipNum(h, 24, isHourStartAni),
        const SizedBox(width: 20),
        buildFlipNum(m, 60, isMinuteStartAni),
        const SizedBox(width: 20),
        buildFlipNum(s, 60, isSecondStartAni),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    updateTime();
  }

  void updateTime() {
    DateTime dateTime = DateTime.now();
    var hour = dateTime.hour;
    var minute = dateTime.minute;
    var second = dateTime.second;
    s = second;
    h = hour;
    m = minute;
    setState(() {
      if (h != 0) {
        isHourStartAni = hour > h;
      }
      if (minute != 0) {
        isMinuteStartAni = minute > m;
      }
      isSecondStartAni = true;
      if (isHourStartAni) {
        h = hour;
      }
      if (isMinuteStartAni) {
        m = minute;
      }
      s = (s + 1) % 60;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  /// [num] 数字
  /// [carry]  进制
  Widget buildFlipNum(int num, int carry, bool isStartAni) {
    int next = (num + 1) % carry;
    String numStr = num < 10 ? "0" + num.toString() : num.toString();
    String nextNumStr = next < 10 ? "0" + next.toString() : next.toString();
    return FlipContainer(
      onAniEndListener: updateTime,
      isStartAni: isStartAni,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Text(
              numStr,
              style: const TextStyle(color: Colors.white, fontSize: 70),
            ),
            color: Colors.black,
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Text(
              nextNumStr,
              style: const TextStyle(color: Colors.white, fontSize: 70),
            ),
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

class FlipContainer extends StatefulWidget {
  List<Widget> children;
  bool isStartAni;
  VoidCallback? onAniEndListener;

  FlipContainer(
      {Key? key,
      this.children = const <Widget>[],
      this.isStartAni = false,
      this.onAniEndListener})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FlipContainerState();
  }
}

class _FlipContainerState extends State<FlipContainer>
    with SingleTickerProviderStateMixin {
  List<Widget>? _children = [];
  bool _isStartAni = false;
  late Widget _topTileHalfWidget;
  late Widget _topAniHalfWidget;
  late Widget _bottomTileHalfWidget;
  late Widget _bottomAniHalfWidget;
  late AnimationController _controller;
  late Animation _animationTop;
  late Animation _animationBottom;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..addListener(() => setState(() {}))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _controller.reset();
              widget.onAniEndListener?.call();
            }
          });
    _animationTop = Tween(begin: .0, end: pi / 2).animate(
        CurvedAnimation(parent: _controller, curve: const Interval(.0, .5)));
    _animationBottom = Tween(begin: -pi / 2, end: .0).animate(
        CurvedAnimation(parent: _controller, curve: const Interval(.5, 1)));
    if (_isStartAni) {
      _controller.forward();
    }
  }

  void initView() {
    _children = widget.children;
    _isStartAni = widget.isStartAni;
    print("initview" + _isStartAni.toString());
    if (_isStartAni) {
      _controller.forward();
    }
    _topTileHalfWidget = ClipRect(
        child: Align(
      child: _children![0],
      alignment: Alignment.bottomCenter,
      heightFactor: 0.5,
    ));
    _topAniHalfWidget = ClipRect(
        child: Align(
      child: _children![0],
      alignment: Alignment.topCenter,
      heightFactor: 0.5,
    ));
    _bottomTileHalfWidget = ClipRect(
        child: Align(
      child: _children![1],
      alignment: Alignment.topCenter,
      heightFactor: 0.5,
    ));
    _bottomAniHalfWidget = ClipRect(
        child: Align(
      child: _children![1],
      alignment: Alignment.bottomCenter,
      heightFactor: 0.5,
    ));
  }

  @override
  Widget build(BuildContext context) {
    initView();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            _bottomTileHalfWidget,
            Transform(
              alignment: Alignment.bottomCenter,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.003)
                ..rotateX(_animationTop.value),
              child: _topAniHalfWidget,
            ),
          ],
        ),
        const SizedBox(
          height: 2,
        ),
        Stack(
          children: [
            _topTileHalfWidget,
            Transform(
              alignment: Alignment.topCenter,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.003)
                ..rotateX(_animationBottom.value),
              child: _bottomAniHalfWidget,
            )
          ],
        )
      ],
    );
  }
}
