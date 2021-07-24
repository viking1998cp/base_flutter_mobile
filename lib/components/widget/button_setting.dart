import 'package:base_flutter_framework/components/widget/circle_icon.dart';
import 'package:base_flutter_framework/components/widget/image.dart';
import 'package:base_flutter_framework/components/widget/text_regular.dart';
import 'package:base_flutter_framework/utils/dimens.dart';
import 'package:base_flutter_framework/utils/string.dart';
import 'package:flutter/material.dart';

Widget buttonSetting({required String count}) {
  return Container(
    height: 60,
    width: 60,
    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    child: Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          child: imageFromLocale(
              url: StringCommon.pathIconSetting,
              width: 25,
              height: 20,
              color: Colors.orange),
        ),
        Container(
          alignment: Alignment.center,
          height: 20,
          width: 15,
          margin: EdgeInsets.only(right: 5),
          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 4),
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(20)),
          child: textRegular(
              color: Colors.white,
              title: count,
              fontSize: DimensCommon.fontSizeSmall),
        ),
      ],
    ),
  );
}
