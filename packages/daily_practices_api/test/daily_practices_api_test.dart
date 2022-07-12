import 'package:flutter_test/flutter_test.dart';

import 'package:daily_practices_api/i_daily_practices_api.dart';

class TestDailyPracticesApi extends IDailyPracticesApi {
  TestDailyPracticesApi() : super();

  @override
  dynamic noSuchMethod(Invocation invocation) {
    return super.noSuchMethod(invocation);
  }
}

void main() {
  group(
    'iDailyPracticesApi',
    () {
      test(
        'can be consturcted',
        () {
          expect(TestDailyPracticesApi.new, returnsNormally);
        },
      );
    },
  );
}
