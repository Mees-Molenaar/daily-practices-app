import 'package:flutter_test/flutter_test.dart';

import 'package:notifications_api/notifications_api.dart';

class TestNotificationsApi extends INotificationsApi {
  TestNotificationsApi() : super();

  @override
  dynamic noSuchMethod(Invocation invocation) {
    return super.noSuchMethod(invocation);
  }
}

void main() {
  group('iNotificationsApi', () {
    test('can be constructed', () {
      expect(TestNotificationsApi.new, returnsNormally);
    });
  });
}
