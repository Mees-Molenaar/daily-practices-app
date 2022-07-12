import 'package:daily_practices_api/src/models/daily_practice.dart';

abstract class IDailyPracticesApi {
  const IDailyPracticesApi();

  Stream<List<DailyPractice>> getDailyPractices();
}
