import 'package:flutter/material.dart';

Widget textBold(
    {required Color color,
    required String title,
    required double fontSize,
    int? maxLine,
    bool? center,
    bool? italic}) {
  return Text(title,
      maxLines: maxLine ?? 100,
      overflow: TextOverflow.ellipsis,
      textAlign: center == true ? TextAlign.center : null,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        fontStyle: italic == true ? FontStyle.italic : FontStyle.normal,
      ));
}
