import 'package:base_flutter_framework/utils/color.dart';
import 'package:flutter/material.dart';

Widget itemDot(Color color) {
  return Container(
    height: 10,
    margin: EdgeInsets.symmetric(horizontal: 7),
    width: 10,
    decoration:
        BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
    child: SizedBox(),
  );
}

Widget pageIndicator({required int currentIndex, required int maxIndex}) {
  List<Widget> list = [];
  for (var i = 0; i < maxIndex; i++) {
    if (currentIndex == i) {
      list.add(itemDot(Colors.blue));
      continue;
    }
    list.add(itemDot(ColorCommon.colorGrey));
  }
  return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Wrap(
        children: list,
      ));
}
