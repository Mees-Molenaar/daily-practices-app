import 'package:daily_practices_app/features/home/home.dart';
import 'package:daily_practices_repository/daily_practices_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:daily_practices_app/app/app.dart';

import '../mocks/mocks.dart';

void main() {
  late DailyPracticesRepository dailyPracticesRepository;

  setUp(() {
    dailyPracticesRepository = MockDailyPracticesRepository();
    when(
      () => dailyPracticesRepository.getDailyPractices(),
    ).thenAnswer((_) => const Stream.empty());
  });

  group('DailyPracticeApp', () {
    testWidgets('renders AppView', (tester) async {
      await tester.pumpWidget(
        DailyPracticeApp(dailyPracticesRepository: dailyPracticesRepository),
      );

      expect(find.byType(AppView), findsOneWidget);
    });
  });

  group('AppView', () {
    testWidgets('renders MaterialApp with correct themes', (tester) async {
      await tester.pumpWidget(RepositoryProvider.value(
        value: dailyPracticesRepository,
        child: const AppView(),
      ));

      expect(find.byType(MaterialApp), findsOneWidget);

      throw UnimplementedError('Need to implement themes');

      // final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      // expect(materialApp.theme, equals(FlutterPracticesTheme.light));
      // expect(materialApp.darkTheme, equals(FlutterPracticesTheme.dark));
    });

    testWidgets('renders PracticesPage', (tester) async {
      await tester.pumpWidget(
        RepositoryProvider.value(
          value: dailyPracticesRepository,
          child: const AppView(),
        ),
      );

      expect(find.byType(PracticesPage), findsOneWidget);
    });
  });
}
