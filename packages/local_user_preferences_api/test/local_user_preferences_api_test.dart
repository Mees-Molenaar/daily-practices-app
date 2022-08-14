import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_preferences_api/user_preferences_api.dart';

import 'package:local_user_preferences_api/local_user_preferences_api.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  group('LocalUserPreferences', () {
    final userPreferences =
        UserPreferences(lastUpdated: DateTime(2002, 05, 08));

    Future<LocalUserPreferencesApi> createSubject(
        Map<String, String> initialValues) async {
      SharedPreferences.setMockInitialValues(initialValues);

      final mockSharedPreferences = await SharedPreferences.getInstance();
      return LocalUserPreferencesApi(
          sharedPreferencesApi: mockSharedPreferences);
    }

    setUp(() {
      resetMocktailState();
    });

    group('constructor', () {
      test('works correctly', () {
        expect(
          () => createSubject({}),
          returnsNormally,
        );
      });
    });
    group('when getting UserPreferences', () {
      group('when a lastUpdated date is stored in shared preferences', () {
        test('it should return UserPreferences', () async {
          final api = await createSubject({});
          final prefs = api.getUserPreferences();
          expect(
            prefs,
            isA<UserPreferences>(),
          );
        });
        test('it should return UserPreferences with the mocked DateTime',
            () async {
          final api = await createSubject({
            'lastUpdated': '2002-05-08',
          });
          final prefs = api.getUserPreferences();
          expect(
            prefs,
            equals(userPreferences),
          );
        });
      });

      group('when a lastUpdated date is not stored in shared preferences', () {
        test('it should return UserPreferences with the date 1992-01-01',
            () async {
          final api = await createSubject({});
          final prefs = api.getUserPreferences();
          expect(
            prefs,
            equals(
              UserPreferences(
                lastUpdated: DateTime(1992, 1, 1),
              ),
            ),
          );
        });
      });
    });

    group('when setting lastUpdated', () {
      test('it should return te userprefrences with the setted value',
          () async {
        final api = await createSubject({});
        api.lastUpdated = DateTime(2022, 4, 11);

        final lastUpdatedUserPreferences = api.getUserPreferences();
        expect(
          lastUpdatedUserPreferences,
          equals(
            UserPreferences(
              lastUpdated: DateTime(2022, 4, 11),
            ),
          ),
        );
      });
    });
  });
}
