// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

import 'package:daily_practices_app/bootstrap.dart';
import 'package:flutter/material.dart';
import 'package:hardcoded_daily_practices_api/hardcoded_daily_practices_api.dart';
import 'package:local_notifications_api/local_notifications_api.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dailyPracticesApi = HardcodedDailyPracticesApi();
  final notifactionsApi =
      LocalNotificationsApi(FlutterLocalNotificationsPlugin());

  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Europe/Amsterdam'));

  final today = tz.TZDateTime.now(tz.local);
  log(today.toString());
  final notificationTime = tz.TZDateTime.local(
    today.year,
    today.month,
    today.day,
    today.hour,
    today.minute,
    today.second,
  );

  await notifactionsApi.initialize();

  notifactionsApi.setNotification(
      notificationTime.add(const Duration(seconds: 10)),
      'Your new daily practice is ready!');

  // Zonder API
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: null,
    macOS: null,
    linux: null,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );

  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails('your channel id', 'your channel name',
          channelDescription: 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker');
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
      0, 'plain title', 'plain body', platformChannelSpecifics,
      payload: 'item x');

  final pendingNotifications =
      await flutterLocalNotificationsPlugin.pendingNotificationRequests();

  print(pendingNotifications[0].title);
  print(pendingNotifications[0].body);

  //final prefs = await SharedPreferences.getInstance();

  bootstrap(dailyPracticesApi: dailyPracticesApi);
}
