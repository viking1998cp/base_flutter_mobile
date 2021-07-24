import 'package:flutter/material.dart';

Widget dropList(
    {required List<String> data,
    required String value,
    required Function onChange,
    Color? textColor,
    bool? symbolTriangle,
    required BuildContext context}) {
  return DropdownButton<String>(
      value: value,
      isExpanded: true,
      isDense: true,
      onChanged: (newValue) {
        onChange(newValue!);
      },
      icon: Icon(
        Icons.arrow_drop_down,
        color: Colors.black,
        size: 0,
      ),
      underline: SizedBox(),
      items: data.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 8),
                  child: Text(
                    value + (symbolTriangle == false ? "" : " ▼"),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: textColor != null ? textColor : Colors.black,
                        fontSize: 16),
                  ),
                )
              ],
            ),
          ),
        );
      }).toList());
}

Widget dropListCustomWidget(
    {required List<String> data,
    required String value,
    required Function onChange,
    required List<DropdownMenuItem<String>>? child,
    required BuildContext context}) {
  return DropdownButton<String>(
      value: value,
      isExpanded: true,
      isDense: true,
      onChanged: (newValue) {
        onChange(newValue);
      },
      icon: Icon(
        Icons.arrow_drop_down,
        color: Colors.black,
        size: 0,
      ),
      underline: SizedBox(),
      items: child);
}
