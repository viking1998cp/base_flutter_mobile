import 'package:base_flutter_framework/components/widget/image.dart';
import 'package:base_flutter_framework/components/widget/text_bold.dart';
import 'package:base_flutter_framework/utils/color.dart';
import 'package:base_flutter_framework/utils/dimens.dart';
import 'package:flutter/material.dart';

Widget buttonIconHorizontal(
    {required String urlIcon,
    required Function() function,
    required double width,
    required double height,
    required String title}) {
  return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white),
      ),
      onPressed: () {
        function();
      },
      child: Column(
        children: [
          imageFromLocale(url: urlIcon, width: width, height: height),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: textBold(
                color: ColorCommon.colorTextGrey,
                title: title,
                fontSize: DimensCommon.fontSizeVerySmall),
          )
        ],
      ));
}
