import 'dart:async';
import 'dart:convert';

import 'dart:io';

import 'package:base_flutter_framework/services/firebase_background/logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateUserTokenAction {
  final String token;

  UpdateUserTokenAction(this.token);
}

class OnPushNotificationReceivedAction {
  final Map<String, dynamic> message;

  OnPushNotificationReceivedAction(this.message);
}

class OnPushNotificationOpenAction {
  final Map<String, dynamic> message;

  OnPushNotificationOpenAction(this.message);
}

class ReceivedNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });
}

enum NotificationType { chat, conservation }

class PushNotification {
  static const KEY_FCM_TOKEN = "KEY_FCM_TOKEN";

  StreamController<OnPushNotificationReceivedAction>
      _onPushNotificationReceivedStreamController = new StreamController();
  StreamController<OnPushNotificationOpenAction>
      _onPushNotificationOpenActionRegistered = new StreamController();
  StreamController<UpdateUserTokenAction> _onUpdateUserTokenActionRegistered =
      new StreamController();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final BehaviorSubject<String> _selectNotificationSubject =
      BehaviorSubject<String>();

  PushNotification(BuildContext context) {
    _localNotificationInit();
    _configureSelectNotificationSubject(context);

    _onPushNotificationReceivedStreamController.stream.listen((event) {
      _onPushNotificationReceived(event);
    });

    _onUpdateUserTokenActionRegistered.stream.listen((event) async {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      await preferences.setString(KEY_FCM_TOKEN, event.token);

      // if (_userRepository != null)
      //   _userRepository.updateFcmToken(token: event.token);
    });

    _onPushNotificationOpenActionRegistered.stream.listen((event) {
      _selectNotificationSubject.add(jsonEncode(event.message));
    });
  }

  /// push notification received action
  onPushNotificationReceivedActionRegistered(Map<String, dynamic> data) {
    _onPushNotificationReceivedStreamController
        .add(OnPushNotificationReceivedAction(data));
  }

  /// push notification open action
  onPushNotificationOpenActionRegistered(Map<String, dynamic> data) {
    _onPushNotificationOpenActionRegistered
        .add(OnPushNotificationOpenAction(data));
  }

  /// push notification update token action
  onUpdateUserTokenActionRegistered(String token) {
    _onUpdateUserTokenActionRegistered.add(UpdateUserTokenAction(token));
  }

  _onPushNotificationReceived(OnPushNotificationReceivedAction action) {
    try {
      final message = _verifyedMessage(action.message);
      if (message == null) {
        return;
      }

      _showNotification(action.message);
    } catch (e) {
      // Logger.e("Failed to display push notification",
      // e: e, s: StackTrace.current);
    }
  }

  Map<String, dynamic>? _verifyedMessage(Map<String, dynamic> message) {
    var notification = message["notification"];
    var data = message["data"];

    // Necessary because the payload format is different per platform
    // See: https://github.com/flutter/flutter/issues/29027
    if (Platform.isIOS) {
      data = message;
      final aps = (data != null) ? data["aps"] : null;
      notification = (aps != null) ? aps["alert"] : null;
    }

    Map<String, dynamic> results = {"data": data, "notification": notification};

    if (notification == null || data == null) {
      print("Empty message payload");
      return null;
    }

    final messageType = data["type"];

    if (messageType == null) {
      print("No action required for type");
      return null;
    }

    var notificationType = _getMessageType(messageType);
    if (notificationType == null) {
      print("No action required for type");
      return null;
    }

    results['type'] = notificationType;

    return results;
  }

  NotificationType? _getMessageType(String messageType) {
    if (messageType == "chat") {
      return NotificationType.chat;
    }

    if (messageType == "conservation") {
      return NotificationType.conservation;
    }

    return null;
  }

  /// init local notification
  void _localNotificationInit() async {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        debugPrint('notification payload: ' + payload);
      }

      if (_selectNotificationSubject != null)
        _selectNotificationSubject.add(payload!);
    });
  }

  /// show local notification
  void _showNotification(Map<String, dynamic> message) {
    Map<String, dynamic> notification = message['notification'];

    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'com.remoteoffer',
      'Flutter chat demo',
      'your channel description',
      playSound: true,
      enableVibration: true,
      importance: Importance.max,
      priority: Priority.high,
    );
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    flutterLocalNotificationsPlugin.show(0, notification['title'].toString(),
        notification['body'].toString(), platformChannelSpecifics,
        payload: json.encode(message));
  }

  /// selected notification then redirect to screen
  void _configureSelectNotificationSubject(BuildContext context) {
    _selectNotificationSubject.stream.listen((String payload) async {
      // navigator
      if (payload == null) {
        return;
      }

      try {
        Map<String, dynamic> payloadObj = jsonDecode(payload);

        final message = _verifyedMessage(payloadObj);
        if (message == null) {
          return;
        }

        NotificationType notificationType = message['type'] as NotificationType;
        if (notificationType == NotificationType.chat) {
          // ignore: unused_local_variable
          Map<String, dynamic> dataMap = message['data'];
          // Navigator.of(context).push(new MaterialPageRoute(
          //     builder: (context) => ChatPage(
          //           id: int.parse(dataMap['conservation_id']),
          //           title: titleCommonMessageAndChat(
          //               dataMap['user_company'], dataMap['company_name']),
          //         )));
        } else if (notificationType == NotificationType.conservation) {
          // navigator
        }
      } catch (e) {
        Logger.e("Failed to show notification $payload",
            e: e, s: StackTrace.current);
      }
    });
  }
}
