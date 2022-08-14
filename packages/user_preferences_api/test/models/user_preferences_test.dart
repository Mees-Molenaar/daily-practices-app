import 'package:flutter_test/flutter_test.dart';
import 'package:user_preferences_api/src/models/user_preferences.dart';

void main() {
  group('User Preferences', () {
    UserPreferences createSubject({
      String lastUpdated = '2002-05-08',
    }) {
      return UserPreferences(
        lastUpdated: lastUpdated,
      );
    }

    group('constructor', () {
      test('works correctly', () {
        expect(
          createSubject,
          returnsNormally,
        );
      });

      test('support value equalitiy', () {
        expect(
          createSubject(),
          equals(createSubject()),
        );
      });

      test('props are correct', () {
        expect(
          createSubject().props,
          equals([
            '2002-05-08',
          ]),
        );
      });
    });

    group('copyWith', () {
      test('returns the same object if no arguments are provided', () {
        expect(
          createSubject().copyWith(),
          equals(createSubject()),
        );
      });

      test('retain the old value for every paramter if null is provided', () {
        expect(
          createSubject().copyWith(
            lastUpdated: null,
          ),
          equals(createSubject()),
        );
      });

      test('replaces every non-null parameter', () {
        expect(
          createSubject().copyWith(lastUpdated: '2022-04-11'),
          equals(
            createSubject(lastUpdated: '2022-04-11'),
          ),
        );
      });
    });

    group('fromJson', () {
      test('works correctly', () {
        expect(
          UserPreferences.fromJson(<String, dynamic>{
            'lastUpdated': '2002-05-08',
          }),
          createSubject(),
        );
      });
    });

    group('toJson', () {
      test('works correctly', () {
        expect(
            createSubject().toJson(),
            equals(<String, dynamic>{
              'lastUpdated': '2002-05-08',
            }));
      });
    });
  });
}
