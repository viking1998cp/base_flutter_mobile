// import 'dart:convert';
// import 'dart:io';
// import 'package:base_flutter_framework/services/fcm.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'dart:async';

// import 'notification/push_notification.dart';

// class FirebaseMessage {

//   static FirebaseMessage? instance;
//   static FirebaseMessage? getInstance() {
//     if (instance == null) {
//       instance = new FirebaseMessage();
//     }

//     return instance;
//   }

//   FirebaseMessage() {}

//   Future<void> getToken() async {
//     token = (await FcmFirebase.getInstance()!
//         .getFcmToken()
//         .timeout(Duration(milliseconds: 3000)))!;
//     if (token == null) {
//       token = "";
//     }

//     return;
//   }
// }
