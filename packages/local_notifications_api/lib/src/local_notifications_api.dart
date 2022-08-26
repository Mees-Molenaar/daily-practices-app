// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

import 'package:notifications_api/notifications_api.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationsApi implements INotificationsApi {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  LocalNotificationsApi(this.flutterLocalNotificationsPlugin);

  Future<bool?> initialize() async {
    try {
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('launcher_icon_foreground');

      const InitializationSettings initializationSettings =
          InitializationSettings(
        android: initializationSettingsAndroid,
      );

      await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  void setNotification(
    tz.TZDateTime notificationTime,
    String message,
  ) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            'daily_practices_channel', 'daily_practices_channel',
            channelDescription:
                'daily practices give a notification once a day',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');

    await flutterLocalNotificationsPlugin.zonedSchedule(
      12456,
      'Daily Practices',
      message,
      notificationTime,
      const NotificationDetails(
        android: androidPlatformChannelSpecifics,
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}
