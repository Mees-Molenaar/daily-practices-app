import 'package:daily_practices_api/daily_practices_api.dart';
import 'package:rxdart/subjects.dart';

class HardcodedDailyPracticesApi implements IDailyPracticesApi {
  final List<DailyPractice> _practices;

  HardcodedDailyPracticesApi(
    this._practices,
  ) {
    _dailyPracticesStreamController.add(_practices);
  }

  final _dailyPracticesStreamController =
      BehaviorSubject<List<DailyPractice>>.seeded(const []);

  @override
  Stream<List<DailyPractice>> getDailyPractices() =>
      _dailyPracticesStreamController.asBroadcastStream();
}
