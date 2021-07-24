import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:base_flutter_framework/utils/color.dart';
import 'package:base_flutter_framework/utils/dimens.dart';
import 'package:flutter/material.dart';

class SKToast {
  static void error({
    required String title,
    required String message,
    required BuildContext context,
    String? textOk,
  }) {
    AwesomeDialog(
      context: context,
      useRootNavigator: true,
      headerAnimationLoop: false,
      btnOkText: textOk ?? "OK",
      btnOkColor: Colors.red,
      dialogType: DialogType.NO_HEADER,
      title: title,
      desc: message,
      btnOkOnPress: () {},
      buttonsTextStyle:
          TextStyle(fontSize: DimensCommon.fontSizeSmall, color: Colors.white),
      btnOkIcon: Icons.close,
    ).show();
  }

  static void success({
    required String title,
    required String message,
    required BuildContext context,
  }) {
    AwesomeDialog(
            context: context,
            useRootNavigator: true,
            animType: AnimType.LEFTSLIDE,
            headerAnimationLoop: false,
            dialogType: DialogType.SUCCES,
            title: title,
            desc: message,
            btnOkText: "OK",
            btnOkOnPress: () {},
            btnOkIcon: Icons.check_circle,
            buttonsTextStyle: TextStyle(
                fontSize: DimensCommon.fontSizeSmall, color: Colors.white),
            onDissmissCallback: () {})
        .show();
  }

  static void warning({
    required String title,
    required String message,
    required String textOk,
    required String textCancel,
    required BuildContext context,
    Function? okClick,
  }) {
    AwesomeDialog(
      context: context,
      useRootNavigator: true,
      headerAnimationLoop: false,
      btnOkText: textOk,
      btnCancelText: textCancel,
      dialogType: DialogType.WARNING,
      animType: AnimType.TOPSLIDE,
      title: title,
      desc: message,
      btnOkOnPress: () {
        if (okClick != null) okClick();
      },
      btnCancelOnPress: () {},
      buttonsTextStyle:
          TextStyle(fontSize: DimensCommon.fontSizeSmall, color: Colors.white),
      btnOkIcon: Icons.close,
    ).show();
  }

  static void info(
      {required String title,
      required String message,
      required String textOk,
      required BuildContext context,
      Function()? okClik}) {
    AwesomeDialog(
      context: context,
      useRootNavigator: true,
      headerAnimationLoop: false,
      btnOkText: textOk,
      btnOkColor: ColorCommon.colorGreen2,
      dialogType: DialogType.INFO,
      title: title,
      desc: message,
      btnOkOnPress: () {
        okClik!();
      },
      buttonsTextStyle:
          TextStyle(fontSize: DimensCommon.fontSizeSmall, color: Colors.white),
      btnOkIcon: Icons.close,
    ).show();
  }
}
