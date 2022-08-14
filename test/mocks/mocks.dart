import 'package:bloc_test/bloc_test.dart';
import 'package:daily_practices_app/features/home/bloc/home_bloc.dart';
import 'package:daily_practices_repository/daily_practices_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:user_preferences_api/user_preferences_api.dart';
import 'package:user_preferences_repository/user_preferences_repository.dart';

class MockDailyPracticesRepository extends Mock
    implements DailyPracticesRepository {}

class MockHomeBlock extends MockBloc<HomeEvent, HomeState> implements HomeBloc {
}

class MockUserPreferencesRepository extends Mock
    implements UserPreferencesRepository {}

class MockUserPreferencesApi extends Mock implements IUserPreferencesApi {}

class FakeDailyPractice extends Fake implements DailyPractice {}
