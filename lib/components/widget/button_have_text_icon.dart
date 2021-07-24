import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget buttonHaveIcon(
    {required String title,
    required Color colorBackground,
    required Color colorIcon,
    required Color textColor,
    required Function onclick,
    required String pathIcon,
    required EdgeInsets margin,
    required EdgeInsets padding,
    double? fontSize,
    double? radius,
    double? iconSizeWidth,
    double? iconSizeHeight}) {
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
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  margin: EdgeInsets.only(right: 10),
                  child: pathIcon.contains(".svg")
                      ? SvgPicture.asset(
                          pathIcon,
                          width: iconSizeWidth ?? 25,
                          height: iconSizeHeight ?? 25,
                          color: colorIcon,
                        )
                      : Image.asset(
                          pathIcon,
                          width: iconSizeWidth ?? 25,
                          height: iconSizeHeight ?? 25,
                        )),
              Text(title,
                  style: TextStyle(color: textColor, fontSize: fontSize ?? 16)),
            ],
          ),
        )),
  );
}
