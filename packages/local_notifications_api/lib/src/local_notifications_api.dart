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
        AndroidNotificationDetails('test_channel', 'test_channel',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');

    log('Hello');
    await flutterLocalNotificationsPlugin.show(
      12345,
      'Daily Practices App',
      'Notification is set! for ${notificationTime.toString()}',
      const NotificationDetails(
        android: androidPlatformChannelSpecifics,
      ),
    );

    log('Is it me your looking foooor');
    await flutterLocalNotificationsPlugin.zonedSchedule(
      12456,
      'Daily Practices App',
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
