import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:learn_flutter/page/route_pager_anim_demo.dart';

class RouteCustomFlowLayoutDemo extends StatelessWidget {
  const RouteCustomFlowLayoutDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: FlowLayout(
        spacing: 20,
        children: [
          ElevatedButton(
            child: Text("TAG"),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const RoutePagerDemo();
              }));
            },
          ),
          ElevatedButton(
            child: Text("TAGTAGTAGTAG"),
            onPressed: null,
          ),
          ElevatedButton(
            child: Text("TAGTAGTAGTAGTAGTAGTAG"),
            onPressed: null,
          ),
          ElevatedButton(
            child: Text("TAGTAGTAGTAGTAGTAGTAGTAGTAG"),
            onPressed: null,
          ),
          ElevatedButton(
            child: Text("TAG"),
            onPressed: null,
          ),
          ElevatedButton(
            child: Text("TAG"),
            onPressed: null,
          ),
        ],
      )),
    );
  }
}

class FlowLayout extends MultiChildRenderObjectWidget {
  double spacing = 0;

  FlowLayout(
      {Key? key, this.spacing = 0, List<Widget> children = const <Widget>[]})
      : super(key: key, children: children);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return FlowLayoutRenderObject();
  }

  @override
  void updateRenderObject(BuildContext context, RenderObject renderObject) {
    (renderObject as FlowLayoutRenderObject).spacing = spacing;
  }
}

class FlowLayoutParentData extends ContainerBoxParentData<RenderBox> {}

class FlowLayoutRenderObject extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, FlowLayoutParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, FlowLayoutParentData> {
  double mHeight = 0;
  double _spacing = 0;

  @override
  void setupParentData(RenderBox child) {
    // 初始化每一个child的parentData
    if (child.parentData is! WrapParentData)
      child.parentData = FlowLayoutParentData();
  }

  set spacing(double spacing) {
    if (spacing == null) {
      return;
    }
    _spacing = spacing;
  }

/*  //因为是纵向换行，横向固定使用父控限定的最大宽度
  double _computeIntrinsicWidthForHeight(double height) {
    return constraints.maxWidth;
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    double width = _computeIntrinsicWidthForHeight(height);
    return width;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    double width = _computeIntrinsicWidthForHeight(height);
    return width;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    double height = mHeight;
    return height;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    double height = mHeight;
    return height;
  }*/

  @override
  void performLayout() {
    final BoxConstraints constraints = this.constraints;
    final BoxConstraints childConstraints =
        BoxConstraints(maxWidth: constraints.maxWidth);
    FlowLayoutParentData childParentData;
    RenderBox? next = firstChild;
    double offsetX = 0;
    double offsetY = 0;
    while (next != null) {
      //传递约束确定子组件Size
      next.layout(childConstraints, parentUsesSize: true);

      //根据布局需要计算布局偏移
      offsetX += next.size.width;
      if (offsetX > constraints.maxWidth) {
        offsetX = 0;
        offsetY += next.size.height;
        childParentData = next.parentData! as FlowLayoutParentData;
        childParentData.offset = Offset(offsetX, offsetY);
        offsetX = next.size.width;
      } else {
        childParentData = next.parentData! as FlowLayoutParentData;
        childParentData.offset = Offset(offsetX - next.size.width, offsetY);
      }
      next = childParentData.nextSibling;
    }
    mHeight = offsetY + lastChild!.size.height;

    //确定自身Size
    size = constraints.constrain(Size(
      double.infinity,
      constraints.maxHeight == double.infinity ? mHeight : double.infinity,
    ));
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }
}
