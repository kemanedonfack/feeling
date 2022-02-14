import 'dart:convert';

import 'package:feeling/constant/constant.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class NotificationController{

  static void initialize() {
    // for ios and web
    FirebaseMessaging.instance.requestPermission();

    FirebaseMessaging.onMessage.listen((event) {
      // print('A new onMessage event was published!');
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // print('A new onMessageOpenedApp event was published!');
    });
  }

  Future<String?> getToken() async {
    return FirebaseMessaging.instance.getToken(vapidKey: "BKF15KlpJC8GCvXg9cbNdSZMLa7ZYHlXsnfLaI9E62LPlo_KwbbCluvgIAe2fYOtXpzkMC1eIog9MxmrEglxlNo");
  }

  /// Send push notification method
  Future<void> sendPushNotification(String titre, String body, String tokenUser) async {
    // Variables
    final Uri url = Uri.parse('https://fcm.googleapis.com/fcm/send');

    await http.post(url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$KEY_MESSAGING',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'title': titre,
            'body': body,
            'color': '#F52354',
            'sound': "default"
          },
          'priority': 'high',
          'to': tokenUser,
        },
      ),
    ).then((http.Response response) {
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('sendPushNotification() -> success ${response.body}');
        }
      }
    }).catchError((error) {
      if (kDebugMode) {
        print('sendPushNotification() -> error: $error');
      }
    });
  }

}
  