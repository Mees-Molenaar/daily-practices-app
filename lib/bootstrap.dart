import 'dart:async';
import 'dart:developer';

import 'package:daily_practices_api/daily_practices_api.dart';
import 'package:daily_practices_app/app/app.dart';
import 'package:daily_practices_app/app/app_bloc_observer.dart';
import 'package:daily_practices_repository/daily_practices_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_preferences_api/user_preferences_api.dart';
import 'package:user_preferences_repository/user_preferences_repository.dart';

void bootstrap({
  required IDailyPracticesApi dailyPracticesApi,
  required IUserPreferencesApi userPreferencesApi,
}) {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  final dailyPracticesRepository =
      DailyPracticesRepository(dailyPracticesApi: dailyPracticesApi);

  final userPreferencesRepository = UserPreferencesRepository(
    userPreferencesApi: userPreferencesApi,
  );

  runZonedGuarded(
    () async {
      Bloc.observer = AppBlocObserver();
      runApp(
        DailyPracticeApp(
          dailyPracticesRepository: dailyPracticesRepository,
          userPreferencesRepository: userPreferencesRepository,
        ),
      );
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
