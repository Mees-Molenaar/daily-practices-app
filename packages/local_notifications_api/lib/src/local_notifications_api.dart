// ignore_for_file: depend_on_referenced_packages

import 'package:notifications_api/notifications_api.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationsApi implements INotificationsApi {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  LocalNotificationsApi(this.flutterLocalNotificationsPlugin);

  Future<bool?> initialize() async {
    try {
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('app_icon');
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
  ) {
    flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Daily Practices App',
      message,
      notificationTime,
      const NotificationDetails(),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
