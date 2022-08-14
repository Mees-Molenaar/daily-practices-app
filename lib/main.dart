// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

import 'package:daily_practices_app/bootstrap.dart';
import 'package:flutter/material.dart';
import 'package:hardcoded_daily_practices_api/hardcoded_daily_practices_api.dart';
import 'package:local_notifications_api/local_notifications_api.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:local_user_preferences_api/local_user_preferences_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:user_preferences_repository/user_preferences_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dailyPracticesApi = HardcodedDailyPracticesApi();
  final notifactionsApi =
      LocalNotificationsApi(FlutterLocalNotificationsPlugin());

  final sharedPreferencesApi = await SharedPreferences.getInstance();

  final UserPreferencesApi =
      LocalUserPreferencesApi(sharedPreferencesApi: sharedPreferencesApi);

  // Setup reoccuring notification

  final List<ActiveNotification>? activeNotifications = await notifactionsApi
      .flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.getActiveNotifications();

  if (activeNotifications?.isEmpty ?? true) {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Europe/Amsterdam'));

    final today = tz.TZDateTime.now(tz.local);

    // TODO: Change this notification time to next day at 07.00!
    // TODO: Misschien moet ook dit gewoon een herhaalde worden?
    // TODO: Deze tijd kan uiteindelijk ook uit preferences gehaald worden!
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
  } else {
    log('Notification for next day is already set!');
  }

  bootstrap(
    dailyPracticesApi: dailyPracticesApi,
    userPreferencesApi: UserPreferencesApi,
  );
}
