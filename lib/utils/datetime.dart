import 'package:base_flutter_framework/translations/app_translations.dart';
import 'package:base_flutter_framework/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeCommon {
  static String formatTime(BuildContext context, DateTime date) {
    try {
      DateFormat dateFormat;
      if (MediaQuery.of(context).alwaysUse24HourFormat) {
        dateFormat =
            DateFormat.Hm(Localizations.localeOf(context).languageCode);
      } else {
        dateFormat =
            DateFormat.jm(Localizations.localeOf(context).languageCode);
      }
      return dateFormat.format(date);
    } catch (error) {
      // Logger.e("Error with time format: $error", e: error, s: StackTrace.current);
      return "";
    }
  }

  static String formatDate(BuildContext context, DateTime date) {
    try {
      final datePattern = "dd/MM/yyyy";
      final dateFormat =
          DateFormat(datePattern, Localizations.localeOf(context).languageCode);
      String th =
          AppTranslations.of(context).text((date.weekday + 1).toString());

      String day = ", " + dateFormat.format(date);

      return th + day;
    } catch (error) {
      // Logger.e("Error with date format: $error", e: error, s: StackTrace.current);
      return "";
    }
  }

  static String formatDateNoContext(DateTime date) {
    try {
      final datePattern = "dd-M-yyyy";
      final dateFormat = DateFormat(datePattern);
      String day = dateFormat.format(date);

      return day;
    } catch (error) {
      // Logger.e("Error with date format: $error", e: error, s: StackTrace.current);
      return "";
    }
  }

  static DateTime getTimeNow(String timeZone) {
    DateTime nowLocale = DateTime.now();
    // ignore: unnecessary_null_comparison
    if (timeZone == null) {
      return nowLocale;
    }
    Duration duration = DateTime.now().timeZoneOffset;
    String hourLocale;
    if (duration.inHours < 10) {
      if (duration.inHours < 0) {
        hourLocale = "-0" + (duration.inHours * -1).toString();
      } else {
        hourLocale = "+0" + duration.inHours.toString();
      }
    } else {
      hourLocale = "+0" + duration.inHours.toString();
    }

    String minuteLocales;
    int minuteLocale = (duration.inHours * 60) - duration.inMinutes;
    if (minuteLocale < 10) {
      minuteLocales = "0" + minuteLocale.toString();
    } else {
      minuteLocales = minuteLocale.toString();
    }
    String timeZoneLocale = hourLocale + ":" + minuteLocales;
    DateTime timeUtc0 =
        DateTime.parse(formatDateTime2(nowLocale) + timeZoneLocale);
    if (timeZone == "") return timeUtc0;

    String timeZoneFlowCountries;
    if (timeZone.substring(0, 1) == "+") {
      timeZoneFlowCountries = "-" + timeZone.substring(1);
    } else {
      timeZoneFlowCountries = "+" + timeZone.substring(1);
    }
    return DateTime.parse(formatDateTime2(timeUtc0) + timeZoneFlowCountries);
  }

  static String dateTimeToString(DateTime dateTime) {
    return DateFormat('MM/dd/yyyy').format(dateTime);
  }

  static String dateTimeToString5(DateTime dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm').format(dateTime);
  }

  static String dateTimeToString6(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  static String dateTimeToString2(DateTime dateTime) {
    return DateFormat('yyyy/MM/dd').format(dateTime);
  }

  static String dateTimeToStringCustom(DateTime dateTime, String? format) {
    return DateFormat(format ?? 'yyyy/MM/dd').format(dateTime);
  }

  static String dateTimeToString3(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  static String dateTimeToString2NodayJapan(DateTime dateTime) {
    return DateFormat('yyyy年MM月').format(dateTime);
  }

  static String dateTimeToString2Noday(DateTime dateTime) {
    return DateFormat('yyyy-MM').format(dateTime);
  }

  static String dateTimeToString4(DateTime dateTime) {
    return DateFormat('yyyy/MM').format(dateTime);
  }

  static DateTime convertStringToDate3(String dateString) {
    DateFormat df2 = new DateFormat(StringCommon
        .datePattern3); // dd-MM-yyyy HH:mm:ss =  2020-06-24 09:50:44
    var date;
    try {
      date = df2.parse(dateString); //  dateString = "dd-MM-yyyy HH:mm:ss";
      /*formatteddate = df.format(date);*/
    } catch (_ex) {}
    return date;
  }

  static DateTime convertStringToDateCustom(String dateString, String format,
      {String? excepTionFormat}) {
    DateFormat df2 =
        new DateFormat(format); // dd-MM-yyyy HH:mm:ss =  2020-06-24 09:50:44
    var date;
    try {
      date = df2.parse(dateString); //  dateString = "dd-MM-yyyy HH:mm:ss";
      /*formatteddate = df.format(date);*/
    } catch (_ex) {
      df2 = new DateFormat(excepTionFormat);
      date = df2.parse(dateString);
    }
    return date;
  }

  static String formatDateTime(String dateString) {
    var dateMessage = convertStringToDate3(dateString);
    DateTime nowLocale = DateTime.now();
    Duration duration = DateTime.now().timeZoneOffset;
    String hourLocale;
    if (duration.inHours < 10) {
      if (duration.inHours < 0) {
        hourLocale = "-0" + (duration.inHours * -1).toString();
      } else {
        hourLocale = "+0" + duration.inHours.toString();
      }
    } else {
      hourLocale = "-0" + duration.inHours.toString();
    }

    String minuteLocales;
    int minuteLocale = (duration.inHours * 60) - duration.inMinutes;
    if (minuteLocale < 10) {
      minuteLocales = "0" + minuteLocale.toString();
    } else {
      minuteLocales = minuteLocale.toString();
    }
    String timeZoneLocale = hourLocale + ":" + minuteLocales;
    DateTime timeUtc0 =
        DateTime.parse(formatDateTime2(nowLocale) + timeZoneLocale);
    int countHourSended;
    int minuteSended;
    int monthSended;
    int yearSended;
    int daySended;
    yearSended = (timeUtc0.year - dateMessage.year);
    if (yearSended >= 1) {
      monthSended = ((timeUtc0.month + 12) - dateMessage.month);
    } else {
      monthSended = (timeUtc0.month - dateMessage.month);
    }

    if (monthSended == 0) {
      daySended = timeUtc0.day - dateMessage.day;
    } else {
      daySended = 0;
    }
    countHourSended = (timeUtc0.hour - dateMessage.hour);

    minuteSended = (timeUtc0.minute - dateMessage.minute).abs();

    if (daySended > 7 || monthSended >= 1 || yearSended >= 1) {
      DateTime timeUtcLocale =
          DateTime.parse(formatDateTime2(dateMessage) + timeZoneLocale);
      return formatDateJapan2(timeUtcLocale);
    } else if (daySended <= 7 && daySended >= 1) {
      if (daySended == 1) {
        return "昨日";
      }
      return daySended.toString() + StringCommon.beforeDayAgo;
    } else if (countHourSended > 1 && countHourSended <= 24) {
      return countHourSended.toString() + StringCommon.beforeHour;
    } else {
      if (countHourSended == 1) {
        return (timeUtc0.minute + 60 - dateMessage.minute).toString() +
            StringCommon.beforeMinute;
      } else {
        if (minuteSended == 0) {
          return StringCommon.fewSecondAgo;
        } else
          return minuteSended.toString() + StringCommon.beforeMinute;
      }
    }
  }

  static String formatDateTimeNoti(String dateString) {
    var dateMessage = convertStringToDate3(dateString);
    DateTime nowLocale = DateTime.now();
    Duration duration = DateTime.now().timeZoneOffset;
    String hourLocale;
    if (duration.inHours < 10) {
      if (duration.inHours < 0) {
        hourLocale = "-0" + (duration.inHours * -1).toString();
      } else {
        hourLocale = "+0" + duration.inHours.toString();
      }
    } else {
      hourLocale = "-0" + duration.inHours.toString();
    }

    String minuteLocales;
    int minuteLocale = (duration.inHours * 60) - duration.inMinutes;
    if (minuteLocale < 10) {
      minuteLocales = "0" + minuteLocale.toString();
    } else {
      minuteLocales = minuteLocale.toString();
    }
    String timeZoneLocale = hourLocale + ":" + minuteLocales;
    DateTime timeUtc0 =
        DateTime.parse(formatDateTime2(nowLocale) + timeZoneLocale);
    // timeUtc0 = DateTime.parse(formatDateTime2(timeUtc0) + "-09:00");
    int countHourSended;
    int minuteSended;
    int monthSended;
    int yearSended;
    int daySended;
    yearSended = (timeUtc0.year - dateMessage.year);
    if (yearSended >= 1) {
      monthSended = ((timeUtc0.month + 12) - dateMessage.month);
    } else {
      monthSended = (timeUtc0.month - dateMessage.month);
    }

    if (monthSended == 0) {
      daySended = timeUtc0.day - dateMessage.day;
    } else {
      daySended = 0;
    }
    countHourSended = (timeUtc0.hour - dateMessage.hour);

    minuteSended = (timeUtc0.minute - dateMessage.minute).abs();
    DateTime timeUtcLocale = DateTime.parse(formatDateTime2(dateMessage));
    if (daySended >= 1 || monthSended >= 1 || yearSended >= 1) {
      return formatDateJapan2(timeUtcLocale);
    } else if (countHourSended > 1 && countHourSended <= 24) {
      return countHourSended.toString() + StringCommon.beforeHour;
    } else {
      if (countHourSended == 1) {
        return (timeUtc0.minute + 60 - dateMessage.minute).toString() +
            StringCommon.beforeMinute;
      } else {
        if (minuteSended == 0) {
          return "今";
        } else
          return minuteSended.toString() + StringCommon.beforeMinute;
      }
    }
  }

  static String formatDateTimeComment(String dateString) {
    var dateMessage = convertStringToDate3(dateString);
    DateTime nowLocale = DateTime.now();
    Duration duration = DateTime.now().timeZoneOffset;

    String hourLocale = "9";
    String minuteLocales;
    int minuteLocale = (duration.inHours * 60) - duration.inMinutes;
    if (minuteLocale < 10) {
      minuteLocales = "0" + minuteLocale.toString();
    } else {
      minuteLocales = minuteLocale.toString();
    }
    String timeZoneLocale = hourLocale + ":" + minuteLocales;
    DateTime timeUtc0 =
        DateTime.parse(formatDateTime2(nowLocale) + "+0" + timeZoneLocale);
    // ignore: unused_local_variable
    int countHourSended;
    // ignore: unused_local_variable
    int minuteSended;
    int monthSended;
    int yearSended;
    // ignore: unused_local_variable
    int daySended;
    yearSended = (timeUtc0.year - dateMessage.year);
    if (yearSended >= 1) {
      monthSended = ((timeUtc0.month + 12) - dateMessage.month);
    } else {
      monthSended = (timeUtc0.month - dateMessage.month);
    }

    if (monthSended == 0) {
      daySended = timeUtc0.day - dateMessage.day;
    } else {
      daySended = 0;
    }
    countHourSended = (timeUtc0.hour - dateMessage.hour);

    minuteSended = (timeUtc0.minute - dateMessage.minute).abs();

    DateTime timeUtcLocale =
        DateTime.parse(formatDateTime2(dateMessage) + "-0" + timeZoneLocale);
    return formatDateToHour(timeUtcLocale);
  }

  static String getTimeUtc0() {
    DateTime nowLocale = DateTime.now();
    Duration duration = DateTime.now().timeZoneOffset;
    String hourLocale;
    hourLocale = "" + (duration.inHours).toString();
    String minuteLocales;
    int minuteLocale = (duration.inHours * 60) - duration.inMinutes;
    if (minuteLocale < 10) {
      minuteLocales = "0" + minuteLocale.toString();
    } else {
      minuteLocales = minuteLocale.toString();
    }
    String timeZoneLocale = hourLocale + ":" + minuteLocales;
    DateTime timeUtc0 =
        DateTime.parse(formatDateTime4(nowLocale) + "+0" + timeZoneLocale);
    return formatDateTime4(timeUtc0);
  }

  static String formatDateTime2(DateTime date) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
  }

  static DateTime formatStringToDate2(String date) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').parse(date);
  }

  static DateTime formatStringToDate4(String date) {
    return DateFormat('HH:mm,dd/MM/yyyy').parse(date);
  }

  static DateTime formatStringToDate5(String date) {
    return DateFormat('yyyy dd/MM HH:mm').parse(date);
  }

  static DateTime formatStringToDate6(String date) {
    return DateFormat('yyyy dd/MM').parse(date);
  }

  static String formatDateTime3(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static String formatDateTime4(DateTime date) {
    return DateFormat('yyyy-MM-dd HH:mm:ss.SSSSSS').format(date);
  }

  static String formatDateToHour(DateTime date) {
    return DateFormat('HH:mm').format(date);
  }

  static String formatDateToNameImage(DateTime date) {
    return DateFormat('yyyyMMddHHmmss').format(date);
  }

  static String formatDateJapan(DateTime date) {
    String? dayName;
    switch (date.weekday) {
      case 1:
        dayName = "月";
        break;
      case 2:
        dayName = "火";
        break;
      case 3:
        dayName = "水";
        break;
      case 4:
        dayName = "木";
        break;
      case 5:
        dayName = "金";
        break;
      case 6:
        dayName = "土";
        break;
      case 7:
        dayName = "日";
        break;
    }

    return ((DateFormat('yyyy年MM月dd日').format(date)) + "（$dayName）");
  }

  static String formatDateJapan2(DateTime date) {
    return ((DateFormat('yyyy年MM月dd日').format(date)));
  }

  static String formatDateJapan2NoDay(DateTime date) {
    return ((DateFormat('yyyy年MM月').format(date)));
  }

  static DateTime convertStringJapanToDateNoDay(String dateString) {
    DateFormat df2 = new DateFormat(
        'yyyy年MM月'); // dd-MM-yyyy HH:mm:ss =  2020-06-24 09:50:44
    var date;
    try {
      date = df2.parse(dateString); //  dateString = "dd-MM-yyyy HH:mm:ss";
      /*formatteddate = df.format(date);*/
    } catch (_ex) {
      print(_ex);
    }
    return date;
  }

  static DateTime convertStringJapanToDate(String dateString) {
    DateFormat df2 = new DateFormat(
        'yyyy年MM月dd'); // dd-MM-yyyy HH:mm:ss =  2020-06-24 09:50:44
    var date;
    try {
      date = df2.parse(dateString); //  dateString = "dd-MM-yyyy HH:mm:ss";
      /*formatteddate = df.format(date);*/
    } catch (_ex) {
      print(_ex);
    }
    return date;
  }

  static DateTime convertStringToDate4(String dateString) {
    DateFormat df2 = new DateFormat(
        'yyyy-MM-dd HH:mm:ss.SSSSSS'); // dd-MM-yyyy HH:mm:ss =  2020-06-24 09:50:44
    var date;
    try {
      date = df2.parse(dateString); //  dateString = "dd-MM-yyyy HH:mm:ss";
      /*formatteddate = df.format(date);*/
    } catch (_ex) {
      print(_ex);
    }
    return date;
  }

  static DateTime convertDateToString5(String dateString) {
    DateFormat df2 = new DateFormat(
        'yyyy/MM/dd'); // dd-MM-yyyy HH:mm:ss =  2020-06-24 09:50:44
    var date;
    try {
      date = df2.parse(dateString); //  dateString = "dd-MM-yyyy HH:mm:ss";
      /*formatteddate = df.format(date);*/
    } catch (_ex) {
      print(_ex);
    }
    return date;
  }

  static DateTime convertDateToStringCustom(String dateString, String? format) {
    DateFormat df2 = new DateFormat(
        format ?? 'yyyy/MM/dd'); // dd-MM-yyyy HH:mm:ss =  2020-06-24 09:50:44
    var date;
    try {
      date = df2.parse(dateString); //  dateString = "dd-MM-yyyy HH:mm:ss";
      /*formatteddate = df.format(date);*/
    } catch (_ex) {
      print(_ex);
    }
    return date;
  }

  static DateTime convertDateToString6(String dateString) {
    DateFormat df2 =
        new DateFormat('yyyy/MM'); // dd-MM-yyyy HH:mm:ss =  2020-06-24 09:50:44
    var date;
    try {
      date = df2.parse(dateString); //  dateString = "dd-MM-yyyy HH:mm:ss";
      /*formatteddate = df.format(date);*/
    } catch (_ex) {
      print(_ex);
    }
    return date;
  }

  static DateTime convertDateToString7(String dateString) {
    DateFormat df2 = new DateFormat('yyyy-MM-dd');
    var date;
    try {
      date = df2.parse(dateString);
      /*formatteddate = df.format(date);*/
    } catch (_ex) {
      print(_ex);
    }
    return date;
  }
}
