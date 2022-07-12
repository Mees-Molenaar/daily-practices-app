import 'package:daily_practices_app/bootstrap.dart';
import 'package:flutter/material.dart';
import 'package:hardcoded_daily_practices_api/hardcoded_daily_practices_api.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final dailyPracticesApi = HardcodedDailyPracticesApi();

  bootstrap(dailyPracticesApi: dailyPracticesApi);
}
