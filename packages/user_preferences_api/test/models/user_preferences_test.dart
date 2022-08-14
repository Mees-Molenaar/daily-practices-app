import 'package:flutter_test/flutter_test.dart';
import 'package:user_preferences_api/src/models/user_preferences.dart';

void main() {
  group('User Preferences', () {
    UserPreferences createSubject({required DateTime lastUpdated}) {
      return UserPreferences(
        lastUpdated: lastUpdated,
      );
    }

    group('constructor', () {
      test('works correctly', () {
        expect(
          () => createSubject(lastUpdated: DateTime(2002, 05, 08)),
          returnsNormally,
        );
      });

      test('support value equalitiy', () {
        expect(
          createSubject(lastUpdated: DateTime(2002, 05, 08)),
          equals(createSubject(lastUpdated: DateTime(2002, 05, 08))),
        );
      });

      test('props are correct', () {
        expect(
          createSubject(lastUpdated: DateTime(2002, 05, 08)).props,
          equals([
            DateTime(2002, 05, 08),
          ]),
        );
      });
    });

    group('copyWith', () {
      test('returns the same object if no arguments are provided', () {
        expect(
          createSubject(lastUpdated: DateTime(2002, 05, 08)).copyWith(),
          equals(createSubject(lastUpdated: DateTime(2002, 05, 08))),
        );
      });

      test('retain the old value for every paramter if null is provided', () {
        expect(
          createSubject(lastUpdated: DateTime(2002, 05, 08)).copyWith(
            lastUpdated: null,
          ),
          equals(createSubject(lastUpdated: DateTime(2002, 05, 08))),
        );
      });

      test('replaces every non-null parameter', () {
        expect(
          createSubject(lastUpdated: DateTime(2002, 05, 08))
              .copyWith(lastUpdated: DateTime(2022, 04, 11)),
          equals(
            createSubject(lastUpdated: DateTime(2022, 04, 11)),
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
          createSubject(lastUpdated: DateTime(2002, 05, 08)),
        );
      });
    });

    group('toJson', () {
      test('works correctly', () {
        expect(
            createSubject(lastUpdated: DateTime(2002, 05, 08)).toJson(),
            equals(<String, dynamic>{
              'lastUpdated': '2002-05-08',
            }));
      });
    });
  });
}
