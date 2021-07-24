import 'package:base_flutter_framework/utils/color.dart';
import 'package:base_flutter_framework/utils/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget searchBox(
    {required String hintText,
    required Function? searchComfirm(String text),
    required TextEditingController controller}) {
  return Container(
    height: 45,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10))),
    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    child: TextFormField(
      inputFormatters: [
        LengthLimitingTextInputFormatter(20),
      ],
      style:
          TextStyle(fontSize: DimensCommon.fontSizeSmall, color: Colors.black),
      controller: controller,
      onFieldSubmitted: (value) {
        searchComfirm(value);
      },
      decoration: InputDecoration(
          filled: true,
          prefixIcon: Icon(Icons.search),
          hintText: hintText,
          border: InputBorder.none,
          hintStyle: TextStyle(
              fontSize: DimensCommon.fontSizeMedium,
              color: ColorCommon.colorHintText)),
    ),
  );
}
