import 'package:flutter/material.dart';

Widget textRegular(
    {required Color color,
    required String title,
    required double fontSize,
    TextAlign? align,
    double? lineHeight,
    int? maxLine}) {
  return Text(
    title,
    style: TextStyle(
      color: color,
      fontSize: fontSize,
      height: lineHeight ?? 1.3,
    ),
    maxLines: maxLine ?? 100,
    overflow: TextOverflow.ellipsis,
    textAlign: align == null ? TextAlign.start : align,
  );
}
