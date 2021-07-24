import 'package:flutter/material.dart';

Widget buttonCircle(
    {required Color colorBackground,
    required Function onclick,
    required EdgeInsets margin,
    required EdgeInsets padding,
    required Widget child,
    double? radius}) {
  return TextButton(
    onPressed: () {
      onclick();
    },
    child: Container(
        margin: margin,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius ?? 5),
            color: colorBackground),
        padding: padding,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(radius ?? 30.0), child: child)),
  );
}
