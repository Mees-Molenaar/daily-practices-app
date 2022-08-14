import 'package:flutter_test/flutter_test.dart';

import 'package:user_preferences_api/user_preferences_api.dart';

class TestUserPreferencesApi extends IUserPreferencesApi {
  TestUserPreferencesApi() : super();

  @override
  dynamic noSuchMethod(Invocation invocation) {
    return super.noSuchMethod(invocation);
  }
}

void main() {
  group(
    'iUserPreferencesApi',
    () {
      test(
        'can be consturcted',
        () {
          expect(TestUserPreferencesApi.new, returnsNormally);
        },
      );
    },
  );
}
