import 'package:daily_practices_api/src/models/daily_practice.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Daily Practice', () {
    DailyPractice createSubject({
      int id = 1,
      String practice = 'practice',
    }) {
      return DailyPractice(
        id: id,
        practice: practice,
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
          equals(
            [
              1,
              'practice',
            ],
          ),
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
            id: null,
            practice: null,
          ),
          equals(createSubject()),
        );
      });

      test('replaces every non-null parameter', () {
        expect(
            createSubject().copyWith(
              id: 2,
              practice: 'new practice',
            ),
            equals(
              createSubject(id: 2, practice: 'new practice'),
            ));
      });
    });

    group('fromJson', () {
      test('works correctly', () {
        expect(
          DailyPractice.fromJson(<String, dynamic>{
            'id': 1,
            'practice': 'practice',
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
              'id': 1,
              'practice': 'practice',
            }));
      });
    });
  });
}
