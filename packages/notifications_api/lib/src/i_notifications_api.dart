import 'package:timezone/timezone.dart' as tz;

abstract class INotificationsApi {
  const INotificationsApi();

  void setNotification(
    tz.TZDateTime notificationTime,
    String message,
  );
}
