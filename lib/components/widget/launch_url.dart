import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LaunchUrl {
  static String urlQrRegisterCar =
      "heartsBCR://mygarageengi://?index_car_select_from_qr.html?mode=heartsBCR&m=s";
  static String urlInstallQrIos =
      "https://apps.apple.com/vn/app/%E8%BB%8A%E6%A4%9C%E8%A8%BCqrcode-for-mygarage/id1329348853";

  static String urlInstallQrAndroid =
      "https://play.google.com/store/apps/details?id=com.hearts.heartsBCR";

  static String urlCarEdit =
      "heartsBCR://mygarageengi://?index_mygarage_carregistration_edit.html?mode=heartsBCR&m=s";
  static String urlCarOpenApp = "heartsBCR://mygarageengi://";
  static launchUrl({required String url, required BuildContext context}) async {
    try {
      bool openUrl = await launch(url);
      if (!openUrl) {
        if (url.contains("heartsBCR://mygarageengi://?")) {
          if (Platform.isAndroid) {
            await launch(urlInstallQrAndroid);
          } else {
            await launch(urlInstallQrIos);
          }
        }
      }
    } catch (_e) {
      if (Platform.isAndroid) {
        await launch(urlInstallQrAndroid);
      } else {
        await launch(urlInstallQrIos);
      }
    }
  }
}
