import 'package:base_flutter_framework/components/widget/text_regular.dart';
import 'package:base_flutter_framework/utils/dimens.dart';
import 'package:flutter/material.dart';

Widget iconNotification(
    {required Widget icon,
    required Color color,
    required countNoti,
    required Function() onclick}) {
  return GestureDetector(
    onTap: () {
      onclick();
    },
    child: Container(
      child: Stack(
        children: [
          Container(alignment: Alignment.bottomCenter, child: icon),
          countNoti > 0
              ? Container(
                  margin: EdgeInsets.only(bottom: 10, left: 13),
                  child: Container(
                      height: 19,
                      padding: EdgeInsets.all(2),
                      width: 19,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: textRegular(
                          color: Colors.white,
                          title: countNoti.toString(),
                          fontSize: DimensCommon.fontSizeVerySmall)),
                )
              : Container(
                  height: 19,
                  width: 19,
                  margin: EdgeInsets.only(bottom: 10, left: 13),
                  child: SizedBox(),
                )
        ],
      ),
    ),
  );
}
