import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_preferences_api/user_preferences_api.dart';

class LocalUserPreferencesApi implements IUserPreferencesApi {
  final SharedPreferences sharedPreferencesApi;

  LocalUserPreferencesApi({required this.sharedPreferencesApi});
  @override
  UserPreferences getUserPreferences() {
    final lastUpdated = _lastUpdated;

    return UserPreferences(lastUpdated: lastUpdated);
  }

  DateTime get _lastUpdated {
    final storedLastUpdated = sharedPreferencesApi.getString('lastUpdated');

    final lastUpdated = storedLastUpdated ??
        '1992-01-01'; // It returns a date in the far past if no date is present

    return DateTime.parse(lastUpdated);
  }

  @override
  set lastUpdated(DateTime lastUpdated) {
    final dateFormat = DateFormat('y-MM-dd');

    sharedPreferencesApi.setString(
        'lastUpdated', dateFormat.format(lastUpdated));
  }
}
