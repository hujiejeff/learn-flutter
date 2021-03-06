import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class RouteFLipClockDemo extends StatelessWidget {
  const RouteFLipClockDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(
          child: FlipClock(),
        ),
      ),
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
    return OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
      List<Widget> children = [
        buildFlipNum(num: h, carry: 24, isStartAni: isHourStartAni),
        const SizedBox(width: 20, height: 20),
        buildFlipNum(num: m, carry: 60, isStartAni: isMinuteStartAni),
        const SizedBox(width: 20, height: 20),
        buildFlipNum(
            num: s, carry: 60, isStartAni: isSecondStartAni, isSecond: true),
      ];
      Widget parent;
      if (orientation == Orientation.landscape) {
        parent = Row(mainAxisSize: MainAxisSize.min, children: children);
      } else {
        parent = Column(mainAxisSize: MainAxisSize.min, children: children);
      }
      return Container(
        child: parent,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    DateTime dateTime = DateTime.now();
    h = dateTime.hour;
    m = dateTime.minute;
    s = dateTime.second;
    updateTime();
  }

  void updateTime() {
    DateTime dateTime = DateTime.now();
    var hour = dateTime.hour;
    var minute = dateTime.minute;
    setState(() {
      if (isHourStartAni) {
        h = hour;
        isHourStartAni = false;
      }
      if (isMinuteStartAni) {
        m = minute;
        isMinuteStartAni = false;
      }
      isSecondStartAni = true;
      s = (s + 1) % 60;
      if (s == 59) {
        isMinuteStartAni = true;
      }
      if (m == 59 && s == 59) {
        isHourStartAni = true;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  /// [num] ??????
  /// [carry]  ??????
  Widget buildFlipNum(
      {int num = 0,
      int carry = 10,
      bool isStartAni = false,
      bool isSecond = false}) {
    int next = (num + 1) % carry;
    String numStr = num < 10 ? "0" + num.toString() : num.toString();
    String nextNumStr = next < 10 ? "0" + next.toString() : next.toString();
    return FlipContainer(
      onAniEndListener: isSecond ? updateTime : null,
      isStartAni: isStartAni,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Container(
            width: 200,
            height: 200,
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Text(
              numStr,
              style: const TextStyle(color: Colors.white, fontSize: 150),
            ),
            color: Color(0xff181a1b),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Container(
            width: 200,
            height: 200,
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Text(
              nextNumStr,
              style: const TextStyle(color: Colors.white, fontSize: 150),
            ),
            color: Color(0xff181a1b),
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
          height: 5,
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
