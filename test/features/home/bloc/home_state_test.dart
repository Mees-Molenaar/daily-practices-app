import 'package:daily_practices_api/daily_practices_api.dart';
import 'package:daily_practices_app/features/home/bloc/home_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const mockPractice = DailyPractice(
    id: 1,
    practice: 'practice',
  );
  final mockPractices = [mockPractice];
  final mockLastUpdated = DateTime(2002, 5, 8);

  group('MockState', () {
    HomeState createSubject({
      List<DailyPractice>? practices,
      DateTime? lastUpdated,
    }) {
      return HomeState(
        practices: practices ?? mockPractices,
        lastUpdated: lastUpdated ?? mockLastUpdated,
      );
    }

    test('supports value equality', () {
      expect(
        createSubject(),
        equals(
          createSubject(),
        ),
      );
    });

    test('props are correct', () {
      expect(
        createSubject(
          practices: mockPractices,
          lastUpdated: mockLastUpdated,
        ).props,
        equals(<Object?>[mockPractices, mockLastUpdated, 1]),
      );
    });

    group('copyWith', () {
      test('returns the same object if no arguments are provided', () {
        expect(
          createSubject().copyWith(),
          equals(
            createSubject(),
          ),
        );
      });

      test('retains the old value for every parameter if null is provided', () {
        expect(
          createSubject().copyWith(
            practices: null,
            lastUpdated: null,
          ),
          equals(
            createSubject(),
          ),
        );
      });

      test('replaces every non-null parameter', () {
        expect(
          createSubject().copyWith(
            practices: [],
            lastUpdated: DateTime(2022, 4, 11),
          ),
          equals(
            createSubject(
              practices: [],
              lastUpdated: DateTime(2022, 4, 11),
            ),
          ),
        );
      });
    });
  });
}
