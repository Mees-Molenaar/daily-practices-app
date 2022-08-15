import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:user_preferences_api/src/models/user_preferences.dart';

void main() {
  group('User Preferences', () {
    UserPreferences createSubject(
        {required DateTime lastUpdated, int activePractice = 1}) {
      return UserPreferences(
        lastUpdated: lastUpdated,
        activePractice: activePractice,
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
            1,
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
            activePractice: null,
          ),
          equals(createSubject(lastUpdated: DateTime(2002, 05, 08))),
        );
      });

      test('replaces every non-null parameter', () {
        expect(
          createSubject(lastUpdated: DateTime(2002, 05, 08)).copyWith(
            lastUpdated: DateTime(2022, 04, 11),
            activePractice: 11,
          ),
          equals(
            createSubject(
              lastUpdated: DateTime(2022, 04, 11),
              activePractice: 11,
            ),
          ),
        );
      });
    });

    group('fromJson', () {
      test('works correctly', () {
        expect(
          UserPreferences.fromJson(<String, dynamic>{
            'lastUpdated': '2002-05-08',
            'activePractice': 1,
          }),
          createSubject(
            lastUpdated: DateTime(2002, 05, 08),
            activePractice: 1,
          ),
        );
      });
    });

    group('toJson', () {
      test('works correctly', () {
        final formatter = DateFormat('y-MM-ddTHH:mm:ss.000');

        expect(
            createSubject(
              lastUpdated: DateTime(2002, 05, 08),
              activePractice: 1,
            ).toJson(),
            equals(<String, dynamic>{
              'lastUpdated': formatter.format(DateTime(2002, 05, 08)),
              'activePractice': 1,
            }));
      });
    });
  });
}
