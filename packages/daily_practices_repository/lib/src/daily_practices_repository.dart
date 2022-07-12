import 'package:daily_practices_api/daily_practices_api.dart';

class DailyPracticesRepository {
  final IDailyPracticesApi _dailyPracticesApi;

  const DailyPracticesRepository({
    required IDailyPracticesApi dailyPracticesApi,
  }) : _dailyPracticesApi = dailyPracticesApi;

  Stream<List<DailyPractice>> getDailyPractices() =>
      _dailyPracticesApi.getDailyPractices();
}
