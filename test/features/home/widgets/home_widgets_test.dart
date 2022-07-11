import 'dart:developer';

import 'package:daily_practices_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Home page smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const DailyPracticeApp());

    // Test dat er een listview is
    final listView = find.byType(ListView);
    expect(listView, findsOneWidget);

    // Test dat je start met 10 listitems op hets scherm
    final listItem = find.byType(ListTile);
    expect(
      listItem,
      findsNWidgets(10),
    );

    // Test je kunt scrollen naar de laatste entry: "Deep Breathing"
    await tester.dragUntilVisible(
      find.text('Deep Breathing!'),
      find.byType(ListView),
      const Offset(250, 0),
    );
  });
}
