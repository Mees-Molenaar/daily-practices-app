import 'package:user_preferences_api/src/models/user_preferences.dart';

abstract class IUserPreferencesApi {
  const IUserPreferencesApi();

  UserPreferences getUserPreferences();
  set lastUpdated(DateTime lastUpdated);
}
