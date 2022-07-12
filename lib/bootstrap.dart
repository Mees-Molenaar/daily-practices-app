import 'dart:async';
import 'dart:developer';

import 'package:daily_practices_api/daily_practices_api.dart';
import 'package:daily_practices_app/app/app.dart';
import 'package:daily_practices_app/app/app_bloc_observer.dart';
import 'package:daily_practices_repository/daily_practices_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void bootstrap({required IDailyPracticesApi dailyPracticesApi}) {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  final dailyPracticesRepository =
      DailyPracticesRepository(dailyPracticesApi: dailyPracticesApi);

  runZonedGuarded(
    () async {
      await BlocOverrides.runZoned(
        () async => runApp(
          DailyPracticeApp(dailyPracticesRepository: dailyPracticesRepository),
        ),
        blocObserver: AppBlocObserver(),
      );
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
