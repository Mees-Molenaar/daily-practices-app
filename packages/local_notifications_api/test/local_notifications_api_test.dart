import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:local_notifications_api/local_notifications_api.dart';
import 'package:mocktail/mocktail.dart';

class MockFlutterLocalNotificationsPlugin extends Mock
    implements FlutterLocalNotificationsPlugin {}

void main() {
  final mockFlutterLocalNotifications = MockFlutterLocalNotificationsPlugin();
  const InitializationSettings initializationSettings =
      InitializationSettings();

  when(() => mockFlutterLocalNotifications.initialize(initializationSettings))
      .thenAnswer((_) => Future.value(true));

  when(() => mockFlutterLocalNotifications.show(any(), any(), any(), any()))
      .thenAnswer((_) async => {});

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
        final api = createSubject();

        api.showNotification('test');

        verify(() =>
                mockFlutterLocalNotifications.show(any(), any(), any(), any()))
            .called(1);
      });
    });
  });
}
