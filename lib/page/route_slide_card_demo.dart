import 'package:flutter/material.dart';
import 'package:learn_flutter/page/view_page.dart';

import 'ClipTransform.dart';

class RouteSlideCardDemo extends StatelessWidget {
  RouteSlideCardDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Container(
        width: 200,
        height: 400,
        // child: PageView.builder(
        //     controller: _pageController,
        //     itemCount: colors.length,
        //     scrollDirection: Axis.vertical,
        //     itemBuilder: itemBuilder),
        child: PageViewJ(
          itemCount: colors.length,
          modifier: const Modifier(
              scrollDirection: Axis.vertical, viewportFraction: 1 / 6),
          transform: ClipTransform(),
          itemBuilder: (context, index) {
            return KeepAliveWrapper(child: ColorBox(index: index));
          },
        ),
      )),
    );
  }

  final PageController _pageController = PageController(viewportFraction: 0.8);

  List<Color> colors = [
    Colors.red,
    Colors.yellow,
    Colors.blue,
    Colors.deepOrangeAccent,
    Colors.cyan,
    Colors.lightGreen,
  ];
  List<String> imgs = [
    'images/img_2.png',
    'images/img_1.png',
    'images/img_2.png',
    'images/img_1.png'
  ];

  Widget itemBuilder(BuildContext context, int index) {
    double page = pageSafe(_pageController);
    double aniValue = 1 - (page - index).abs();
    Widget widget = Container(
      alignment: Alignment.topCenter,
      color: colors[index],
      child: Text("indeex: $index, page: $page"),
    );
    return widget;
  }

  Widget transformWrap(Widget child, double page, int index, double aniValue) {
    print("transformWrap" +
        child.toString() +
        ":" +
        index.toString() +
        ":" +
        page.toString());

    return LayoutBuilder(builder: (context, constraints) {
      double offsetY = -constraints.maxHeight;
      if (page == index) {
        offsetY = 0;
      } else if (page > index) {
        offsetY = constraints.maxHeight;
      } else if (page < index) {
        offsetY = -constraints.maxHeight;
      }
      return Transform.translate(
        offset: Offset(0, 0),
        child: child,
      );
    });
    // return LayoutBuilder(builder: (context, constraints) {
    //   double scale = 1;
    //   // double offsetY = -constraints.maxHeight;
    //   return Transform(
    //     alignment: Alignment.centerLeft,
    //     transform: Matrix4.identity()
    //
    //       ..scale(1)
    //       ..translate(0, 0),
    //     child: child,
    //   );
    // });
  }

  double pageSafe(PageController pageController) {
    if (!pageController.position.hasContentDimensions ||
        pageController.page == null) {
      return 0;
    } else {
      return pageController.page!;
    }
  }
}

class ColorBox extends StatefulWidget {
  int index;

  ColorBox({Key? key, required this.index}) : super(key: key);

  @override
  _ColorBoxState createState() => _ColorBoxState();
}

class _ColorBoxState extends State<ColorBox>
    with AutomaticKeepAliveClientMixin {
  bool _checked = false;

  @override
  void initState() {
    super.initState();
    _checked = false;
    print('-----_ColorBoxState#initState---${widget.index}-------');
  }

  @override
  void dispose() {
    print('-----_ColorBoxState#dispose---${widget.index}-------');
    super.dispose();
  }

  List<Color> colors = [
    Colors.red,
    Colors.yellow,
    Colors.blue,
    Colors.deepOrangeAccent,
    Colors.cyan,
    Colors.lightGreen,
  ];
  List<String> imgs = [
    'images/img_2.png',
    'images/img_1.png',
    'images/img_2.png',
    'images/img_1.png'
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      alignment: Alignment.bottomCenter,
      color: colors[widget.index],
      // child: Image.asset(
      //   imgs[widget.index],
      //   fit: BoxFit.cover,
      // ),
    );
  }

  String colorString(Color color) =>
      "#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";

  @override
  bool get wantKeepAlive => true;
}

class KeepAliveWrapper extends StatefulWidget {
  const KeepAliveWrapper({
    Key? key,
    this.keepAlive = true,
    required this.child,
  }) : super(key: key);
  final bool keepAlive;
  final Widget child;

  @override
  _KeepAliveWrapperState createState() => _KeepAliveWrapperState();
}

class _KeepAliveWrapperState extends State<KeepAliveWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  void didUpdateWidget(covariant KeepAliveWrapper oldWidget) {
    if (oldWidget.keepAlive != widget.keepAlive) {
      // keepAlive 状态需要更新，实现在 AutomaticKeepAliveClientMixin 中
      updateKeepAlive();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  bool get wantKeepAlive => widget.keepAlive;
}
