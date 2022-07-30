import 'package:notifications_api/notifications_api.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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
  void showNotification(String message) {
    flutterLocalNotificationsPlugin.show(
      0,
      'Daily Practices App',
      message,
      null,
    );
  }
}
