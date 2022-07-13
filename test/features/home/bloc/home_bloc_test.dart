import 'package:bloc_test/bloc_test.dart';
import 'package:daily_practices_app/features/home/bloc/home_bloc.dart';
import 'package:daily_practices_repository/daily_practices_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mocks.dart';

void main() {
  const mockPractices = [
    DailyPractice(id: 1, practice: 'practice 1'),
    DailyPractice(id: 1, practice: 'practice 2'),
    DailyPractice(id: 1, practice: 'practice 3'),
  ];

  group('HomeBloc', () {
    late DailyPracticesRepository dailyPracticesRepository;

    setUpAll(() {
      registerFallbackValue(FakeDailyPractice());
    });

    setUp(() {
      dailyPracticesRepository = MockDailyPracticesRepository();
      when(
        () => dailyPracticesRepository.getDailyPractices(),
      ).thenAnswer((_) => Stream.value(mockPractices));
    });

    HomeBloc buildBloc() {
      return HomeBloc(dailyPracticesRepository: dailyPracticesRepository);
    }

    group('constructor', () {
      test('works properly', () => expect(buildBloc, returnsNormally));

      test('has correct initial state', () {
        expect(
          buildBloc().state,
          equals(
            const HomeState(),
          ),
        );
      });
    });

    group('HomeSubscriptionRequested', () {
      blocTest<HomeBloc, HomeState>(
        'start listening to repository getDailyPractices stream',
        build: buildBloc,
        act: (bloc) => bloc.add(const HomeSubscriptionRequested()),
        verify: (_) {
          verify(() => dailyPracticesRepository.getDailyPractices()).called(1);
        },
      );

      blocTest<HomeBloc, HomeState>(
        'emits state with updated practices'
        'when repository getDailyPractices stream emits new practices',
        build: buildBloc,
        act: (bloc) => bloc.add(const HomeSubscriptionRequested()),
        expect: () => [
          const HomeState(
            practices: mockPractices,
          ),
        ],
      );
    });
  });
}
