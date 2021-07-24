import 'package:base_flutter_framework/utils/color.dart';
import 'package:base_flutter_framework/utils/dimens.dart';
import 'package:base_flutter_framework/utils/navigator.dart';
import 'package:flutter/material.dart';

Widget scaffoldPadding(
    {required BuildContext context,
    required Widget child,
    bool? resizeToAvoidBottomInset,
    bool? paddingBool,
    Widget? bottomWidget,
    Color? backgroundColor}) {
  return GestureDetector(
    onTap: () {
      FocusScope.of(context).requestFocus(FocusNode());
    },
    child: Scaffold(
      backgroundColor: backgroundColor ?? ColorCommon.colorGrey2,
      resizeToAvoidBottomInset:
          resizeToAvoidBottomInset ?? !NavigatorCommon.isshowingDialog,
      body: Container(
        padding: paddingBool == false
            ? EdgeInsets.all(0)
            : DimensCommon.paddingCommon(context: context),
        child: child,
      ),
      bottomNavigationBar: bottomWidget,
    ),
  );
}
