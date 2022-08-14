import 'package:user_preferences_api/user_preferences_api.dart';

class UserPreferencesRepository {
  final IUserPreferencesApi _userPreferencesApi;

  const UserPreferencesRepository({
    required IUserPreferencesApi userPreferencesApi,
  }) : _userPreferencesApi = userPreferencesApi;

  DateTime getLastUpdated() => _userPreferencesApi.userPreferences.lastUpdated;
}
