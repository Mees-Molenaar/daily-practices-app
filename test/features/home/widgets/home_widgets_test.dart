import 'package:daily_practices_app/app/app.dart';
import 'package:daily_practices_repository/daily_practices_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mocks.dart';

void main() {
  late DailyPracticesRepository api;

  const practices = [
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

  setUp(() {
    api = MockDailyPracticesRepository();
    when(() => api.getDailyPractices()).thenAnswer((_) => const Stream.empty());
  });

  group('Widget test', () {
    testWidgets('Home page smoke test', (WidgetTester tester) async {
      await tester.pumpWidget(DailyPracticeApp(
        dailyPracticesRepository: api,
      ));

      // Test dat er een listview is
      final listView = find.byType(ListView);
      expect(
        listView,
        findsOneWidget,
        reason: 'List View should be made',
      );

      // Test dat je listitems op je scherm hebt
      final listItem = find.byType(ListTile);
      expect(
        listItem,
        findsWidgets,
        reason: 'Multiple list tile should be made',
      );

      // Test je kunt scrollen naar de laatste entry: "Deep Breathing"
      await tester.dragUntilVisible(
        find.text('Deep Breathing!'),
        find.byType(ListView),
        const Offset(250, 0),
      );
    });
  });
}
