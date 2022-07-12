import 'package:daily_practices_api/daily_practices_api.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:daily_practices_repository/daily_practices_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockDailyPracticesApi extends Mock implements IDailyPracticesApi {}

class FakeDailyPractice extends Fake implements DailyPractice {}

void main() {
  group('DailyPracticesRepository', () {
    late IDailyPracticesApi api;

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

    setUpAll(() {
      registerFallbackValue(FakeDailyPractice());
    });

    setUp(() {
      api = MockDailyPracticesApi();
      when(() => api.getDailyPractices())
          .thenAnswer((_) => Stream.value(practices));
    });

    DailyPracticesRepository createSubject() =>
        DailyPracticesRepository(dailyPracticesApi: api);

    group('constructor', () {
      test('works correctly', () {
        expect(
          createSubject,
          returnsNormally,
        );
      });
    });

    group('getDailyPractices', () {
      test('makes correct api request', () {
        final repository = createSubject();

        expect(
          repository.getDailyPractices(),
          isNot(throwsA(anything)),
        );
      });

      test('returns stream of current list daily practices', () {
        expect(
          createSubject().getDailyPractices(),
          emits(practices),
        );
      });
    });
  });
}
