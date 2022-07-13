import 'package:daily_practices_app/features/home/bloc/home_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HomeEvent', () {
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
