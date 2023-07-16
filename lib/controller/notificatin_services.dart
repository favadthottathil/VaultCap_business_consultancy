import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  void requestNotificationPermission() async {
    await messaging.requestPermission();
    // NotificationSettings settings = await messaging.requestPermission(
    //   alert: true,
    //   announcement: true,
    //   badge: true,
    //   carPlay: true,
    //   criticalAlert: true,
    //   provisional: true,
    //   sound: true,
    // );

    // if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    //   print('user granded permission');
    // } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    //   print('user granted provisional permissin');
    // } else {
    //   print('user denied permission');
    // }
  }

  // void initLocalNotifications(BuildContext context, RemoteMessage message) async {
  //   var androidInitializationSettings = const AndroidInitializationSettings('@mipmap/ic_launcher');
  //   var iosInitializationSettings = const DarwinInitializationSettings();

  //   var initializationSetting = InitializationSettings(
  //     android: androidInitializationSettings,
  //     iOS: iosInitializationSettings,
  //   );

  //   await flutterLocalNotificationsPlugin.initialize(
  //     initializationSetting,
  //     onDidReceiveNotificationResponse: (payload) {},
  //   );
  // }

  Future<void> showNotification(RemoteMessage message) async {
    if (message.notification != null && message.notification!.title != null) {
      AndroidNotificationChannel channel = AndroidNotificationChannel(
        Random.secure().nextInt(1000).toString(),
        'High Importance Notification',
        importance: Importance.max,
      );

      AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
        channel.id.toString(),
        channel.name.toString(),
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.max,
        ticker: 'ticker',
        enableVibration: true,
        icon: "@mipmap/ic_launcher",
      );

      DarwinNotificationDetails darwinNotificationDetails = const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails, iOS: darwinNotificationDetails);

      Future.delayed(
        Duration.zero,
        () {
          flutterLocalNotificationsPlugin.show(
            DateTime.now().millisecond,
            message.notification!.title.toString(),
            message.notification!.body.toString(),
            notificationDetails,
          );
        },
      );
    } else if (message.notification!.body != null) {
      // show notification with a body

      AndroidNotificationChannel channel = AndroidNotificationChannel(Random.secure().nextInt(1000).toString(), 'High Importance Notification', importance: Importance.max);

      AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(channel.id.toString(), channel.name.toString(), channelDescription: 'your channel description', importance: Importance.low, priority: Priority.max, ticker: 'ticker', enableVibration: true, icon: "@mipmap/ic_launcher");

      DarwinNotificationDetails darwinNotificationDetails = const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: darwinNotificationDetails,
      );

      Future.delayed(
        Duration.zero,
        () {
          flutterLocalNotificationsPlugin.show(
            DateTime.now().millisecond,
            "",
            message.notification!.body.toString(),
            notificationDetails,
          );
        },
      );
    } else {
      
    }
  }

  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();

    return token!;
  }

  void isTokenRefresh() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
    });
  }

  void firebaseInit() {
    FirebaseMessaging.onMessage.listen((event) {
      if (kDebugMode) {
        print(event.notification!.title.toString());

        print(event.notification!.body.toString());
      }

      showNotification(event);
    });
  }
}
