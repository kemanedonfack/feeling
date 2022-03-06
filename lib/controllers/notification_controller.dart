import 'dart:convert';

import 'package:feeling/constant/constant.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class NotificationController{

  static void initialize() {
    // for ios and web
    FirebaseMessaging.instance.requestPermission();

    FirebaseMessaging.onMessage.listen((event) {
      // print('Nouveau Message!');
      display(event);
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

  
  static final _notificationsPlugin = FlutterLocalNotificationsPlugin();

  static void initializeLocalNotification(){

    const InitializationSettings initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/launcher_icon')
    );
    _notificationsPlugin.initialize(initializationSettings);
  }
  void showNotification(String body) async {

    final id = DateTime.now().millisecondsSinceEpoch ~/1000;
      
      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          'feeling_channel', 
          'feeling_channel name',
          importance: Importance.max,
          priority: Priority.high
        ),
        iOS: IOSNotificationDetails()
      );
      
      await _notificationsPlugin.show(id, "Feeling", body, notificationDetails);
    
  }

  static void display(RemoteMessage message) async { 

    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/1000;
      
      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          'feeling_channel', 
          'feeling_channel name',
          importance: Importance.max,
          priority: Priority.high
        ),
        iOS: IOSNotificationDetails()
      );
      
      await _notificationsPlugin.show(id, message.notification!.title, message.notification!.body, notificationDetails);
    } on Exception catch (e) {
      if (kDebugMode) {
        print("message d'erreur local notification $e");
      }
    }
  }


}
  