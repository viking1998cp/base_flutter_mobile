import 'package:flutter/material.dart';

Widget draggebleAnimation(
    {required Widget child,
    required double x,
    required double y,
    required Function(Offset) onDragEnd}) {
  return Positioned(
      left: x,
      top: y,
      child: Draggable(
          child: child,
          maxSimultaneousDrags: 1,
          feedback: SizedBox(),
          childWhenDragging: child,
          onDragEnd: (dragDetails) {
            onDragEnd(dragDetails.offset);
          },
          onDragUpdate: (dragDetails) {}
          // onDraggableCanceled: (velocity, offset) {
          //   onDragEnd(offset);
          // }),
          ));
}
