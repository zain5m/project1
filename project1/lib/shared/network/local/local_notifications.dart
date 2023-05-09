import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotifications {
  //!create Notification Plugin
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
// ! Model user Resever
  // static SocialUserModel? modelResever;

// ! Initialzeion Local Notification
  static void initialze(context) {
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
    );
    _notificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (payload) async {
        if (payload != null) {
          var resever = json.decode(payload);
          print(payload);
          // modelResever = SocialUserModel.fromJson(resever);
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => ChatDetailsScreen(
          //       userReseverModel: modelResever,
          //     ),
          // ),
          // CupertinoPageRoute
          // );
        }
      },
    );
  }

//! Disply Notification
  static void display(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          "easyapproach",
          "easyapproach channel",
          channelDescription: "this is our channel",
          importance: Importance.max,
          priority: Priority.high,
        ),
      );
      // !Show Notification
      await _notificationsPlugin.show(
        id,
        message.data["user_name"],
        message.data["body"],
        notificationDetails,
        payload: message.data["post_id"] ?? message.data["user_id"],
      );
    } on Exception catch (e) {
      print(e);
    }
  }
}
