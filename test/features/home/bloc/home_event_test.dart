import 'package:daily_practices_api/daily_practices_api.dart';
import 'package:daily_practices_app/features/home/bloc/home_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HomeEvent', () {
    const mockPractice = DailyPractice(id: 1, practice: 'practice');

    group('HomeSubscriptionRequested', () {
      test('supports value equality', () {
        expect(
          const HomeSubscriptionRequested(),
          equals(const HomeSubscriptionRequested()),
        );
      });

      test('props are correct', () {
        expect(
          const HomeSubscriptionRequested().props,
          equals(<Object?>[]),
        );
      });
    });
  });
}
