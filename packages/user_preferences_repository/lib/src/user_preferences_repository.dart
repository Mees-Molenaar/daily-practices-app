import 'package:user_preferences_api/user_preferences_api.dart';

class UserPreferencesRepository {
  final IUserPreferencesApi _userPreferencesApi;

  const UserPreferencesRepository({
    required IUserPreferencesApi userPreferencesApi,
  }) : _userPreferencesApi = userPreferencesApi;

  DateTime getLastUpdated() =>
      _userPreferencesApi.getUserPreferences().lastUpdated;

  void setLastUpdated(DateTime lastUpdated) =>
      _userPreferencesApi.lastUpdated = lastUpdated;

  int getActivePractice() =>
      _userPreferencesApi.getUserPreferences().activePractice;

  void setActivePractice(int activePractice) =>
      _userPreferencesApi.activePractice = activePractice;
}
