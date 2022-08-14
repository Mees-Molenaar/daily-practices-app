import 'package:daily_practices_app/features/home/view/home.dart';
import 'package:daily_practices_app/theme/theme.dart';
import 'package:daily_practices_repository/daily_practices_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:daily_practices_app/app/app.dart';
import 'package:user_preferences_repository/user_preferences_repository.dart';

import '../mocks/mocks.dart';

void main() {
  late DailyPracticesRepository dailyPracticesRepository;
  late UserPreferencesRepository userPreferencesRepository;

  setUp(() {
    dailyPracticesRepository = MockDailyPracticesRepository();
    when(
      () => dailyPracticesRepository.getDailyPractices(),
    ).thenAnswer((_) => const Stream.empty());

    userPreferencesRepository = MockUserPreferencesRepository();

    when(() => userPreferencesRepository.getLastUpdated()).thenReturn(
      DateTime(
        2002,
        05,
        08,
      ),
    );
  });

  group('DailyPracticeApp', () {
    testWidgets('renders AppView', (tester) async {
      await tester.pumpWidget(
        DailyPracticeApp(
          dailyPracticesRepository: dailyPracticesRepository,
          userPreferencesRepository: userPreferencesRepository,
        ),
      );

      expect(find.byType(AppView), findsOneWidget);
    });
  });

  group('AppView', () {
    testWidgets('renders MaterialApp with correct themes', (tester) async {
      await tester.pumpWidget(MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (_) => dailyPracticesRepository),
          RepositoryProvider(create: (_) => userPreferencesRepository),
        ],
        child: const AppView(),
      ));

      expect(find.byType(MaterialApp), findsOneWidget);

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.theme, equals(FlutterPracticesTheme.light));
      expect(materialApp.darkTheme, equals(FlutterPracticesTheme.dark));
    });

    testWidgets('renders PracticesPage', (tester) async {
      await tester.pumpWidget(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider(create: (_) => dailyPracticesRepository),
            RepositoryProvider(create: (_) => userPreferencesRepository),
          ],
          child: const AppView(),
        ),
      );

      expect(find.byType(PracticesPage), findsOneWidget);
    });
  });
}
