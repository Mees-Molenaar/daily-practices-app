import 'package:daily_practices_app/app/app.dart';
import 'package:daily_practices_app/features/home/bloc/home_bloc.dart';
import 'package:daily_practices_app/features/home/view/home.dart';
import 'package:daily_practices_repository/daily_practices_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:user_preferences_api/user_preferences_api.dart';
import 'package:user_preferences_repository/user_preferences_repository.dart';

import '../../../mocks/mocks.dart';

void main() {
  late DailyPracticesRepository dailyPracticesRepository;
  late UserPreferencesRepository userPreferencesRepository;

  const mockPractices = [
    DailyPractice(
      id: 1,
      practice: 'test practice',
    ),
    DailyPractice(
      id: 2,
      practice: 'test practice 2',
    ),
    DailyPractice(
      id: 3,
      practice: 'test practice 3',
    ),
  ];

  final mockUserPreferencesApi = MockUserPreferencesApi();
  when(() => mockUserPreferencesApi.getUserPreferences()).thenReturn(
    UserPreferences(
      lastUpdated: DateTime(
        2002,
        05,
        08,
      ),
      activePractice: 1,
    ),
  );

  group('PracticesPage', () {
    setUp(() {
      dailyPracticesRepository = MockDailyPracticesRepository();
      when(() => dailyPracticesRepository.getDailyPractices())
          .thenAnswer((_) => const Stream.empty());

      userPreferencesRepository = MockUserPreferencesRepository();

      when(() => userPreferencesRepository.getLastUpdated()).thenReturn(
        DateTime(
          2002,
          05,
          08,
        ),
      );

      when(() => userPreferencesRepository.getActivePractice()).thenReturn(10);
    });

    testWidgets('renders PracticesView', (tester) async {
      await tester.pumpWidget(
        DailyPracticeApp(
          dailyPracticesRepository: dailyPracticesRepository,
          userPreferencesRepository: userPreferencesRepository,
        ),
      );

      expect(find.byType(PracticesView), findsOneWidget);
    });

    testWidgets('subscribes to practices from repository on initialization',
        (tester) async {
      await tester.pumpWidget(
        DailyPracticeApp(
          dailyPracticesRepository: dailyPracticesRepository,
          userPreferencesRepository: userPreferencesRepository,
        ),
      );

      verify(() => dailyPracticesRepository.getDailyPractices()).called(1);
    });
  });

  group('PracticesView', () {
    late HomeBloc homeBloc;

    setUp(() {
      dailyPracticesRepository = MockDailyPracticesRepository();
      when(dailyPracticesRepository.getDailyPractices)
          .thenAnswer((_) => const Stream.empty());
    });

    Widget buildSubject(
      HomeBloc homeBloc,
    ) {
      return BlocProvider<HomeBloc>(
        create: (context) => homeBloc,
        child: const MaterialApp(home: PracticesView()),
      );
    }

    testWidgets('renders AppBar with title text', (tester) async {
      homeBloc = MockHomeBlock();
      when(() => homeBloc.state).thenReturn(
        HomeState(
          practices: mockPractices,
          lastUpdated: DateTime(2022, 5, 8),
        ),
      );
      await tester.pumpWidget(buildSubject(homeBloc));

      expect(find.byType(AppBar), findsOneWidget);
      expect(
        find.descendant(
          of: find.byType(AppBar),
          matching: find.text('Daily Practices'),
        ),
        findsOneWidget,
      );
    });

    group('when practices is empty', () {
      setUp(() {
        homeBloc = MockHomeBlock();
        when(() => homeBloc.state).thenReturn(
          HomeState(
            practices: mockPractices,
            lastUpdated: DateTime(2022, 5, 8),
          ),
        );

        when(() => homeBloc.state).thenReturn(
          HomeState(
            lastUpdated: DateTime(2022, 5, 8),
          ),
        );
      });

      testWidgets('renders no listitems', (tester) async {
        await tester.pumpWidget(buildSubject(homeBloc));

        expect(find.byType(ListTile), findsNothing);
      });
    });

    group('when practices is not empty', () {
      setUp(() {
        homeBloc = MockHomeBlock();
        when(() => homeBloc.state).thenReturn(
          HomeState(
            practices: mockPractices,
            lastUpdated: DateTime(2022, 5, 8),
          ),
        );

        when(() => homeBloc.state).thenReturn(
          HomeState(
            practices: mockPractices,
            lastUpdated: DateTime(2022, 5, 8),
          ),
        );
      });
      testWidgets('renders all listitems', (tester) async {
        await tester.pumpWidget(buildSubject(homeBloc));

        expect(find.byType(Card), findsNWidgets(mockPractices.length));
      });
    });

    group('when the lastUpdated is far from the current date', () {
      setUp(() {
        homeBloc = MockHomeBlock();
        when(() => homeBloc.state).thenReturn(
          HomeState(
            practices: mockPractices,
            lastUpdated: DateTime(2022, 5, 8),
          ),
        );
      });
      testWidgets('it should start the newDayEvent', (tester) async {
        await tester.pumpWidget(buildSubject(homeBloc));
        tester.binding
            .handleAppLifecycleStateChanged(AppLifecycleState.resumed);

        verify(() => homeBloc.add(const NewDayEvent())).called(1);
      });
    });

    group('when the lastUpdated is one day from the current date', () {
      setUp(() {
        final today = DateTime.now();
        homeBloc = MockHomeBlock();
        when(() => homeBloc.state).thenReturn(
          HomeState(
            practices: mockPractices,
            lastUpdated: today.subtract(const Duration(days: 1)),
          ),
        );
      });
      testWidgets('it should start the newDayEvent', (tester) async {
        await tester.pumpWidget(buildSubject(homeBloc));
        tester.binding
            .handleAppLifecycleStateChanged(AppLifecycleState.resumed);

        verify(() => homeBloc.add(const NewDayEvent())).called(1);
      });
    });

    group('when the lastUpdated is the same day as today', () {
      setUp(() {
        final today = DateTime.now();
        homeBloc = MockHomeBlock();
        when(() => homeBloc.state).thenReturn(
          HomeState(
            practices: mockPractices,
            lastUpdated: today,
          ),
        );
      });
      testWidgets('it should not start the newDayEvent', (tester) async {
        await tester.pumpWidget(buildSubject(homeBloc));
        tester.binding
            .handleAppLifecycleStateChanged(AppLifecycleState.resumed);

        verifyNever(() => homeBloc.add(const NewDayEvent()));
      });
    });

    group(
        'when the lastUpdated is a future date (which should not be possible)',
        () {
      setUp(() {
        final today = DateTime.now();
        homeBloc = MockHomeBlock();
        when(() => homeBloc.state).thenReturn(
          HomeState(
            practices: mockPractices,
            lastUpdated: today.add(const Duration(days: 1)),
          ),
        );
      });
      testWidgets('it should not start the newDayEvent', (tester) async {
        await tester.pumpWidget(buildSubject(homeBloc));
        tester.binding
            .handleAppLifecycleStateChanged(AppLifecycleState.resumed);

        verifyNever(() => homeBloc.add(const NewDayEvent()));
      });
    });
  });
}
