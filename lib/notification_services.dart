import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class notification_Services {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterlocalnotificationplugin =
      FlutterLocalNotificationsPlugin();

  void requestnotificationpermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("user granted permession");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("user granted permession");
    } else {
      print("user denied permession");
    }
  }

  void ontokenrefresh() {
    messaging.onTokenRefresh.listen(
      (event) {
        event.toString();
      },
    );
    print('Token Refresh');
  }

  Future<String> getdevicetoken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  void firebaseinit() {
    FirebaseMessaging.onMessage.listen(
      (message) {
        if (kDebugMode) {
          print(message.notification!.title.toString());
          print(message.notification!.body.toString());
        }
        shownotification(message);
      },
    );
  }

  void initlocalnotifications(
      BuildContext context, RemoteMessage message) async {
    var androidinitializesettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosinitializesettings = DarwinInitializationSettings();
    var initiallizesetting = InitializationSettings(
      android: androidinitializesettings,
      iOS: iosinitializesettings,
    );

    await flutterlocalnotificationplugin.initialize(initiallizesetting,
        onDidReceiveBackgroundNotificationResponse: (payload) {});
  }

  Future<void> shownotification(message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      Random.secure().nextInt(100000).toString(),
      'High Importance',
      importance: Importance.max,
      groupId: '1',
    );
    AndroidNotificationDetails androidnotificationdetail =
        AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
      icon: 'ic_launcher',
      channelDescription: 'Your Channel Description',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
    );
    DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    NotificationDetails notificationdetails = NotificationDetails(
      android: androidnotificationdetail,
      iOS: darwinNotificationDetails,
    );
    Future.delayed(Duration.zero, () {
      flutterlocalnotificationplugin.show(
          0,
          message.notification.title!.toString(),
          message.notification.body!.toString(),
          notificationdetails);
    });
  }
}
