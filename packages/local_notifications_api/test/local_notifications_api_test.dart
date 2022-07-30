// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:local_notifications_api/local_notifications_api.dart';
import 'package:mocktail/mocktail.dart';

import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class MockFlutterLocalNotificationsPlugin extends Mock
    implements FlutterLocalNotificationsPlugin {}

void main() {
  final mockFlutterLocalNotifications = MockFlutterLocalNotificationsPlugin();
  // Fake Inputs
  const InitializationSettings initializationSettings =
      InitializationSettings();
  const NotificationDetails notificationDetails = NotificationDetails();
  const UILocalNotificationDateInterpretation
      uiLocalNotificationDateInterpretation =
      UILocalNotificationDateInterpretation.absoluteTime;

  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Europe/Amsterdam'));

  final today = tz.TZDateTime.now(tz.local);
  final notificationTime = today.add(const Duration(minutes: 5));

  when(() => mockFlutterLocalNotifications.initialize(initializationSettings))
      .thenAnswer((_) => Future.value(true));

  when(() => mockFlutterLocalNotifications.zonedSchedule(
        any(),
        any(),
        any(),
        notificationTime,
        notificationDetails,
        uiLocalNotificationDateInterpretation:
            uiLocalNotificationDateInterpretation,
        androidAllowWhileIdle: true,
      )).thenAnswer((_) async => {});

  group('LocalNotificationsApi', () {
    LocalNotificationsApi createSubject() {
      return LocalNotificationsApi(mockFlutterLocalNotifications);
    }

    group('constructor', () {
      test('works correctly', () {
        expect(
          createSubject,
          returnsNormally,
        );
      });

      test('initialize', () {
        final api = createSubject();

        expect(
          api.initialize,
          returnsNormally,
        );
      });

      test('set Notification', () {
        registerFallbackValue(tz.TZDateTime);

        final api = createSubject();

        api.setNotification(notificationTime, 'Test');

        verify(() => mockFlutterLocalNotifications.zonedSchedule(
              any(),
              any(),
              any(),
              notificationTime,
              notificationDetails,
              uiLocalNotificationDateInterpretation:
                  uiLocalNotificationDateInterpretation,
              androidAllowWhileIdle: true,
            )).called(1);
      });
    });
  });
}
