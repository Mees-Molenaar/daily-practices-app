library daily_practices_api;

import 'package:daily_practices_api/models/daily_practice.dart';

abstract class IDailyPracticesApi {
  const IDailyPracticesApi();

  Stream<List<DailyPractice>> getDailyPractices();
}
