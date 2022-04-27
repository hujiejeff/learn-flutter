
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:learn_flutter/page/view_page.dart';

class ClipTransform extends StaticTransform {
  ClipTransform();

  @override
  Widget horizontal(double aniValue, int index, double page, Widget child) {
    print("horizontal");
    if (page == index) {
      return child;
    } else if (page > index) {
      return super.horizontal(aniValue, index, page, child);
    } else {
      return ClipRect(
        child: Align(
          widthFactor: aniValue,
          child: super.horizontal(aniValue, index, page, child),
        ),
      );
    }
  }

  @override
  Widget vertical(double aniValue, int index, double page, Widget child) {
    if (page == index) {
      return child;
    } else if (page > index) {
      return child;
    } else {
      return LayoutBuilder(builder: (context, constraints) {
        Widget tran =  Transform(
          transform: Matrix4.translationValues(
              0, (index - page) * -(constraints.maxHeight - 20), 0),
          child: Stack(
            children: [
              child,
              Text("page: $page, index: $index", style: TextStyle(color: Colors.white),)
            ],
          ),
        );
        return tran;


      });
    }
  }

/*  @override
  Widget vertical(double aniValue, int index, double page, Widget child) {
    if (page == index) {
      return child;
    } else if (page > index) {
      return super.vertical(aniValue, index, page, child);
    } else {
      return ClipRect(
        child: Align(
          widthFactor: aniValue,
          child: super.vertical(aniValue, index, page, child),
        ),
      );
    }
  }*/
}
