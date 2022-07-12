import 'package:daily_practices_app/app/app.dart';
import 'package:daily_practices_repository/daily_practices_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDailyPracticesRepository extends Mock
    implements DailyPracticesRepository {}

void main() {
  late DailyPracticesRepository api;

  setUp(() {
    api = MockDailyPracticesRepository();
  });

  group('Widget test', () {
    testWidgets('Home page smoke test', (WidgetTester tester) async {
      await tester.pumpWidget(DailyPracticeApp(
        dailyPracticesRepository: api,
      ));

      // Test dat er een listview is
      final listView = find.byType(ListView);
      expect(listView, findsOneWidget);

      // Test dat je listitems op je scherm hebt
      final listItem = find.byType(ListTile);
      expect(
        listItem,
        findsWidgets,
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
