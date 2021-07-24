import 'package:flutter/material.dart';

Widget circleAvatar(
    {required Widget child, double? radius, Color? backgroundColor}) {
  return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: backgroundColor ?? Colors.transparent),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(radius ?? 30.0), child: child));
}
