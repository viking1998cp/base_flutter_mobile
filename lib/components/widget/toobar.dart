import 'dart:io';

import 'package:base_flutter_framework/utils/dimens.dart';
import 'package:flutter/material.dart';

Widget toolBarCommon(
    {required BuildContext context,
    required Color background,
    required Color colorIcon,
    required Widget child,
    required Function onclickIcon}) {
  IconData icon = Icons.arrow_back_ios;
  if (Platform.isAndroid) {
    icon = Icons.arrow_back;
  }
  return Container(
    height: 50,
    child: Container(
      color: background,
      child: Stack(
        children: [
          Center(
            child: Container(
              alignment: Alignment.center,
              width: DimensCommon.sizeWidth(context: context),
              child: child,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: DimensCommon.sizeBackButton,
                child: IconButton(
                  splashColor: Colors.black,
                  icon: Icon(
                    icon,
                    color: colorIcon,
                    size: DimensCommon.fontSizeIconBig,
                  ),
                  onPressed: () {
                    onclickIcon();
                  },
                ),
              )
            ],
          ),
        ],
      ),
    ),
  );
}
