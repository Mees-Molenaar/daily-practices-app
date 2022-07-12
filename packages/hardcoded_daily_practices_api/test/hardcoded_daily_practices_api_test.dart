import 'package:daily_practices_api/daily_practices_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hardcoded_daily_practices_api/data/practices_data.dart';

import 'package:hardcoded_daily_practices_api/src/hardcoded_daily_practices_api.dart';

void main() {
  group('HardcodedDailyPracticesApi', () {
    final practices = [
      for (var practice in dailyPractices) DailyPractice.fromJson(practice)
    ];

    HardcodedDailyPracticesApi createSubject() {
      return HardcodedDailyPracticesApi();
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
      });
    });

    test('getDailyPractices returns stream of current list practices', () {
      expect(createSubject().getDailyPractices(), emits(practices));
    });
  });
}
