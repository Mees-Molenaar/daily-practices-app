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
      when(() => api.getUserPreferences()).thenReturn(
        UserPreferences(
          lastUpdated: DateTime(
            2002,
            05,
            08,
          ),
          activePractice: 1,
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
      group('setLastUpdated', () {
        test('makes correct api request', () {
          final repository = createSubject();

          expect(
            () => repository.setLastUpdated(
              DateTime(2022, 4, 11),
            ),
            returnsNormally,
          );
        });
      });
    });

    group('activePractice', () {
      group('when getActivePractice is called', () {
        test('it should make a correct api request', () {
          expect(
            createSubject().getActivePractice(),
            isNot(throwsA(anything)),
          );
        });

        test('it should return the activePractice', () {
          expect(
            createSubject().getActivePractice(),
            equals(1),
          );
        });
      });

      group('when setting the activePractice', () {
        test('it should make a correct api request', () {
          expect(
            () => createSubject().setActivePractice(4),
            returnsNormally,
          );
        });
      });
    });
  });
}
