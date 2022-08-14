import 'package:bloc_test/bloc_test.dart';
import 'package:daily_practices_app/features/home/bloc/home_bloc.dart';
import 'package:daily_practices_repository/daily_practices_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:mocktail/mocktail.dart';
import 'package:user_preferences_repository/user_preferences_repository.dart';

import '../../../mocks/mocks.dart';

void main() {
  const mockPractices = [
    DailyPractice(id: 1, practice: 'practice 1'),
    DailyPractice(id: 1, practice: 'practice 2'),
    DailyPractice(id: 1, practice: 'practice 3'),
  ];

  group('HomeBloc', () {
    late DailyPracticesRepository dailyPracticesRepository;
    late UserPreferencesRepository mockUserPreferencesRepository;

    setUpAll(() {
      registerFallbackValue(FakeDailyPractice());
    });

    setUp(() async {
      dailyPracticesRepository = MockDailyPracticesRepository();
      when(
        () => dailyPracticesRepository.getDailyPractices(),
      ).thenAnswer((_) => Stream.value(mockPractices));

      mockUserPreferencesRepository = MockUserPreferencesRepository();

      when(() => mockUserPreferencesRepository.getLastUpdated()).thenAnswer(
        (_) => DateTime(
          2002,
          05,
          08,
        ),
      );
    });

    HomeBloc buildBloc() {
      return HomeBloc(
        dailyPracticesRepository: dailyPracticesRepository,
        userPreferencesRepository: mockUserPreferencesRepository,
      );
    }

    group('constructor', () {
      test('works properly', () => expect(() => buildBloc(), returnsNormally));

      test('has correct initial state', () {
        expect(
          buildBloc().state,
          equals(
            HomeState(
              lastUpdated: DateTime(
                2002,
                05,
                08,
              ),
            ),
          ),
        );
      });
    });

    group('HomeSubscriptionRequested', () {
      blocTest<HomeBloc, HomeState>(
        'start listening to repository getDailyPractices stream',
        build: () {
          return buildBloc();
        },
        act: (bloc) => bloc.add(const HomeSubscriptionRequested()),
        verify: (_) {
          verify(() => dailyPracticesRepository.getDailyPractices()).called(1);
        },
      );

      blocTest<HomeBloc, HomeState>(
        'emits state with updated practices'
        'when repository getDailyPractices stream emits new practices',
        build: () {
          return buildBloc();
        },
        act: (bloc) => bloc.add(const HomeSubscriptionRequested()),
        expect: () => [
          HomeState(
            practices: mockPractices,
            lastUpdated: DateTime(2022, 5, 8),
          ),
        ],
      );
    });

    group('NewDayEvent', () {
      blocTest<HomeBloc, HomeState>(
        'stores the new lastUpdated date into sharedstorage',
        build: () {
          return buildBloc();
        },
        act: (bloc) => bloc.add(const NewDayEvent()),
        verify: (_) {
          verify(() => mockUserPreferencesRepository.setLastUpdated(any()))
              .called(1);
        },
      );

      final today = DateTime.now();
      final formatter = DateFormat('y-MM-dd');
      blocTest<HomeBloc, HomeState>(
        'emits the updated state with the current lastUpdated date',
        build: () {
          return buildBloc();
        },
        act: (bloc) => bloc.add(const NewDayEvent()),
        expect: () => [
          HomeState(
            lastUpdated:
                formatter.parse('${today.year}-${today.month}-${today.day}'),
          ),
        ],
      );
    });
  });
}
