import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:user_preferences_api/user_preferences_api.dart';

import 'package:user_preferences_repository/user_preferences_repository.dart';

class MockUserPreferencesApi extends Mock implements IUserPreferencesApi {}

void main() {
  group('UserPreferencesRepository', () {
    late IUserPreferencesApi api;

    setUp(() {
      api = MockUserPreferencesApi();
      when(() => api.userPreferences).thenReturn(
        UserPreferences(
          lastUpdated: DateTime(
            2002,
            05,
            08,
          ),
        ),
      );
    });

    UserPreferencesRepository createSubject() =>
        UserPreferencesRepository(userPreferencesApi: api);

    group('constructor', () {
      test('works correctly', () {
        expect(
          createSubject,
          returnsNormally,
        );
      });
    });

    group('getLastUpdated', () {
      test('makes correct api request', () {
        final repository = createSubject();

        expect(
          repository.getLastUpdated(),
          isNot(throwsA(anything)),
        );
      });

      test('returns the DateTime of last updated date', () {
        expect(
          createSubject().getLastUpdated(),
          equals(
            DateTime(2002, 05, 08),
          ),
        );
      });
    });
  });
}
