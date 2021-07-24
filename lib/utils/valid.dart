// import 'package:base_flutter_framework/components/components.dart';
import 'package:base_flutter_framework/components/widget/sk_toast.dart';
import 'package:base_flutter_framework/core/models/response.dart';
import 'package:flutter/material.dart';

class VaildCommon {
  // static ResponseCommon checkVaildDataRegister(
  //     {required BuildContext context,
  //     required String email,
  //     required String name,
  //     required String passWord,
  //     required String passWordAgain}) {
  //   if (checkEmptyString(email) ||
  //       checkEmptyString(name) ||
  //       checkEmptyString(passWord) ||
  //       checkEmptyString(passWordAgain)) {
  //     return new ResponseCommon(
  //         code: "false",
  //         message:
  //             AppTranslations.of(context).text(StringCommon.keyInputNotEmpty));
  //   } else {
  //     if (passWord != passWordAgain) {
  //       return new ResponseCommon(
  //           code: "false",
  //           message: AppTranslations.of(context)
  //               .text(StringCommon.keyPassWordAgainError));
  //     } else {
  //       if (passWord.length > 5) {
  //         if (isEmail(email)) {
  //           return new ResponseCommon(code: "true", message: "");
  //         } else {
  //           return new ResponseCommon(
  //               code: "false",
  //               message: AppTranslations.of(context)
  //                   .text(StringCommon.keyInvaildEmail));
  //         }
  //       } else {
  //         return new ResponseCommon(
  //             code: "false",
  //             message: AppTranslations.of(context)
  //                 .text(StringCommon.keyPassWordShort));
  //       }
  //     }
  //   }
  // }

  static ResponseCommon checkVailLogin(
      {required BuildContext context,
      required String email,
      required String pass}) {
    if (checkEmptyString(email) || checkEmptyString(pass)) {
      return new ResponseCommon(code: "false", message: "Thất bại");
    } else {
      if (isEmail(email)) {
        return new ResponseCommon(code: "true", message: "");
      }
      return new ResponseCommon(code: "false", message: "Thành công");
    }
  }

  static bool checkEmptyString(String data) {
    if (data == "") {
      return true;
    }
    return false;
  }

  static bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

  static bool vaildEmail(
      {required BuildContext context, required String email}) {
    if (!checkEmptyString(email) && isEmail(email)) {
      return true;
    } else {
      SKToast.error(
          title: "Có lỗi", message: "Email không hợp lệ", context: context);
      return false;
    }
  }

  static bool isPhoneNumber(String phone) {
    if (phone.length > 8) {
      return true;
    }
    return false;
  }

  static bool checkImageLink(String url) {
    if (url.contains("45.76.209.56:9090/images/")) {
      return true;
    }
    return false;
  }

  static checkMaxLeghtNumber(String text) {
    if (text.isEmpty) return false;
    try {
      if (int.parse(text) > 9999) {
        return true;
      }
    } catch (_e) {}

    return false;
  }

  static checkMaxLeghtText(String text) {
    if (text.isEmpty) return false;
    try {
      if (text.length > 8) {
        return true;
      }
    } catch (_e) {}

    return false;
  }

  static checkDateTimeCompera(DateTime time1, DateTime time2) {
    if (time1.year == time2.year &&
        time1.month == time2.month &&
        time1.day == time2.day) {
      return true;
    }
    return false;
  }
}
