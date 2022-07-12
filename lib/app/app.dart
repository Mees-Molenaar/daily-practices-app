import 'package:daily_practices_app/features/home/home.dart';
import 'package:daily_practices_repository/daily_practices_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DailyPracticeApp extends StatelessWidget {
  final DailyPracticesRepository dailyPracticesRepository;
  const DailyPracticeApp({
    Key? key,
    required this.dailyPracticesRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: dailyPracticesRepository,
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PracticesList(),
    );
  }
}
