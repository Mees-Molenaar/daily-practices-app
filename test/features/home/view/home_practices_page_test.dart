import 'package:daily_practices_app/app/app.dart';
import 'package:daily_practices_app/features/home/bloc/home_bloc.dart';
import 'package:daily_practices_app/features/home/view/home.dart';
import 'package:daily_practices_repository/daily_practices_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';

import '../../../mocks/mocks.dart';

void main() {
  late DailyPracticesRepository dailyPracticesRepository;

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

  group('PracticesPage', () {
    setUp(() {
      dailyPracticesRepository = MockDailyPracticesRepository();
      when(() => dailyPracticesRepository.getDailyPractices())
          .thenAnswer((_) => const Stream.empty());
    });

    testWidgets('renders PracticesView', (tester) async {
      await tester.pumpWidget(
        DailyPracticeApp(
          dailyPracticesRepository: dailyPracticesRepository,
        ),
      );

      expect(find.byType(PracticesView), findsOneWidget);
    });

    testWidgets('subscribes to practices from repository on initialization',
        (tester) async {
      await tester.pumpWidget(
        DailyPracticeApp(
          dailyPracticesRepository: dailyPracticesRepository,
        ),
      );

      verify(() => dailyPracticesRepository.getDailyPractices()).called(1);
    });
  });

  group('PracticesView', () {
    late HomeBloc homeBloc;

    setUp(() {
      homeBloc = MockHomeBlock();
      when(() => homeBloc.state).thenReturn(
        const HomeState(
          practices: mockPractices,
        ),
      );

      dailyPracticesRepository = MockDailyPracticesRepository();
      when(dailyPracticesRepository.getDailyPractices)
          .thenAnswer((_) => const Stream.empty());
    });

    Widget buildSubject() {
      return BlocProvider<HomeBloc>(
        create: (context) => homeBloc,
        child: const MaterialApp(home: PracticesView()),
      );
    }

    testWidgets('renders AppBar with title text', (tester) async {
      await tester.pumpWidget(buildSubject());

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
        when(() => homeBloc.state).thenReturn(
          const HomeState(),
        );
      });

      testWidgets('renders no listitems', (tester) async {
        await tester.pumpWidget(buildSubject());

        expect(find.byType(ListTile), findsNothing);
      });
    });

    group('when practices is not empty', () {
      setUp(() {
        when(() => homeBloc.state).thenReturn(
          const HomeState(
            practices: mockPractices,
          ),
        );
      });
      testWidgets('renders all listitems', (tester) async {
        await tester.pumpWidget(buildSubject());

        expect(find.byType(Card), findsNWidgets(mockPractices.length));
      });
    });
  });
}
