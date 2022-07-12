import 'package:daily_practices_api/daily_practices_api.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hardcoded_daily_practices_api/src/hardcoded_daily_practices_api.dart';

void main() {
  group('HardcodedDailyPracticesApi', () {
    const practices = [
      DailyPractice(
        id: 1,
        practice: 'practice 1',
      ),
      DailyPractice(
        id: 2,
        practice: 'practice 2',
      ),
      DailyPractice(
        id: 3,
        practice: 'practice 3',
      ),
    ];

    HardcodedDailyPracticesApi createSubject({practices = practices}) {
      return HardcodedDailyPracticesApi(practices);
    }

    group('constructor', () {
      test('works correctly', () {
        expect(
          createSubject,
          returnsNormally,
        );
      });

      group('initializes the practices stream', () {
        test('with existing practices present', () {
          final api = createSubject();

          expect(
            api.getDailyPractices(),
            emits(practices),
          );
        });

        test('with empty list if no practices present', () {
          final api = createSubject(practices: const <DailyPractice>[]);

          expect(api.getDailyPractices(), emits(const <DailyPractice>[]));
        });
      });
    });

    test('getDailyPractices returns stream of current list practices', () {
      expect(createSubject().getDailyPractices(), emits(practices));
    });
  });
}
