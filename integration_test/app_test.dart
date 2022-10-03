// ignore_for_file: depend_on_referenced_packages

import 'package:daily_practices_app/app/app.dart';
import 'package:daily_practices_repository/daily_practices_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hardcoded_daily_practices_api/hardcoded_daily_practices_api.dart';
import 'package:integration_test/integration_test.dart';
import 'package:local_user_preferences_api/local_user_preferences_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_preferences_repository/user_preferences_repository.dart';
import 'package:timezone/data/latest_all.dart' as tz;

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  late DailyPracticesRepository dailyPracticesRepository;
  late UserPreferencesRepository userPreferencesRepository;

  setUp(() async {
    final dailyPracticesApi = HardcodedDailyPracticesApi();
    final sharedPreferencesApi = await SharedPreferences.getInstance();

    final userPreferencesApi =
        LocalUserPreferencesApi(sharedPreferencesApi: sharedPreferencesApi);

    dailyPracticesRepository =
        DailyPracticesRepository(dailyPracticesApi: dailyPracticesApi);

    userPreferencesRepository = UserPreferencesRepository(
      userPreferencesApi: userPreferencesApi,
    );
  });

  setUpAll(() {
    tz.initializeTimeZones();
  });

  group('end-to-end test', () {
    testWidgets('all practices are in the list and one is active',
        (tester) async {
      await tester.pumpWidget(
        DailyPracticeApp(
          dailyPracticesRepository: dailyPracticesRepository,
          userPreferencesRepository: userPreferencesRepository,
        ),
      );

      // Wait till app is loaded
      await Future.delayed(const Duration(seconds: 3), () {});

      // Verify that the list can be found
      final listFinder = find.byType(Scrollable);
      expect(listFinder, findsOneWidget);

      // Verify that the first practice can be found
      expect(find.text('Sleep eight hours'), findsOneWidget);

      // Scroll to the bottom
      await tester.fling(
        listFinder,
        const Offset(0, -500),
        10000,
      );
      await tester.pumpAndSettle();

      // Verify that the last practice can be found
      expect(find.text('Deep breathing'), findsOneWidget);

      // Scroll back to the top
      await tester.fling(
        listFinder,
        const Offset(0, 500),
        10000,
      );
      await tester.pumpAndSettle();

      final activeItemFinder = find.byKey(const ValueKey('ActivePractice'));

      // Find the active practice
      await tester.scrollUntilVisible(
        activeItemFinder,
        500.0,
        scrollable: listFinder,
      );

      expect(activeItemFinder, findsOneWidget);
    });
  });
}
