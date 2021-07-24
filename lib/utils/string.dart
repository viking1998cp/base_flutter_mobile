import 'package:intl/intl.dart';

class StringCommon {
  ///File path
  static const String pathBgLogoFlash = "assets/images/bg_logo_app.jpg";
  static const String pathIconMessagerFacebook = "assets/icons/messenger.svg";
  static const String pathBgHeaderApp = "assets/images/bg_app_header.jpg";
  static const String pathKeyIconSellHouse = "assets/icons/icon_sell_house.png";
  static const String pathKeyIconRentHouse = "assets/icons/icon_rent_house.png";
  static const String pathKeyIconTransferHouse =
      "assets/icons/icon_tranfer_house.png";
  static const String pathIconSetting = "assets/icons/settings.svg";
  static const String pathIconCalendar = "assets/icons/calendar.svg";

  static const String pathIconCompass = "assets/icons/icon_compass.svg";
  static const String pathIconFacede = "assets/icons/icon_facade.png";
  static const String pathIconHouse = "assets/icons/icon_house.png";
  static const String pathIconPeople = "assets/icons/icon_people.png";
  static const String pathIconStress = "assets/icons/icon_stress.png";
  static const String pathIconArea = "assets/icons/icon_area.png";

  static const String beforeHour = "時間前";
  static const String beforeMinute = "分前";
  static const String fewSecondAgo = "数秒前";
  static const String beforeDayAgo = "日前";

  ///format
  static const String datePattern3 = "yyyy-MM-dd HH:mm:ss";
  static String formatDecimal(int count) {
    final formatter = new NumberFormat("#,###");
    return formatter.format(count);
  }

  static const hostImageCarEdit = "http://45.76.209.56:9090/images";
  static const hostShareUrl = "https://mg.i-car.jp/spec/";

  //language
  static const String sellBuy = "Mua bán";
  static const String rent = "Cho thuê";
  static const String tranfer = "Sang nhượng";
}
