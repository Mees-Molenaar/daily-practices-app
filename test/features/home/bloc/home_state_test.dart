import 'package:daily_practices_api/daily_practices_api.dart';
import 'package:daily_practices_app/features/home/bloc/home_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const mockPractice = DailyPractice(
    id: 1,
    practice: 'practice',
  );
  final mockPractices = [mockPractice];

  group('MockState', () {
    HomeState createSubject({
      List<DailyPractice>? practices,
    }) {
      return HomeState(practices: practices ?? mockPractices);
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
        createSubject(practices: mockPractices).props,
        equals(<Object?>[mockPractices]),
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
          ),
          equals(
            createSubject(),
          ),
        );
      });

      test('replaces every non-null parameter', () {
        expect(
          createSubject().copyWith(
            practices: () => [],
          ),
          equals(
            createSubject(
              practices: [],
            ),
          ),
        );
      });
    });
  });
}
