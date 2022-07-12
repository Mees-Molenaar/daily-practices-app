import 'package:daily_practices_api/daily_practices_api.dart';
import 'package:rxdart/subjects.dart';

import '../../data/practices_data.dart';

class HardcodedDailyPracticesApi implements IDailyPracticesApi {
  HardcodedDailyPracticesApi() {
    // Store the hardcoded practices in _practices and add them to Stream
    _practices.addAll([
      for (var practice in dailyPractices) DailyPractice.fromJson(practice)
    ]);
    _dailyPracticesStreamController.add(_practices);
  }

  final List<DailyPractice> _practices = <DailyPractice>[];

  final _dailyPracticesStreamController =
      BehaviorSubject<List<DailyPractice>>.seeded(const []);

  @override
  Stream<List<DailyPractice>> getDailyPractices() =>
      _dailyPracticesStreamController.asBroadcastStream();
}
