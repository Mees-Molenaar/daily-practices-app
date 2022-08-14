import 'package:daily_practices_app/features/home/view/home.dart';
import 'package:daily_practices_app/theme/theme.dart';
import 'package:daily_practices_repository/daily_practices_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_preferences_repository/user_preferences_repository.dart';

class DailyPracticeApp extends StatelessWidget {
  final DailyPracticesRepository dailyPracticesRepository;
  final UserPreferencesRepository userPreferencesRepository;
  const DailyPracticeApp({
    Key? key,
    required this.dailyPracticesRepository,
    required this.userPreferencesRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => dailyPracticesRepository),
        RepositoryProvider(create: (_) => userPreferencesRepository),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: FlutterPracticesTheme.light,
      darkTheme: FlutterPracticesTheme.dark,
      home: const PracticesPage(),
    );
  }
}
