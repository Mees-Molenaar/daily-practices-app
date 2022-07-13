import 'package:bloc_test/bloc_test.dart';
import 'package:daily_practices_app/features/home/bloc/home_bloc.dart';
import 'package:daily_practices_repository/daily_practices_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockDailyPracticesRepository extends Mock
    implements DailyPracticesRepository {}

class MockHomeBlock extends MockBloc<HomeEvent, HomeState> implements HomeBloc {
}

class FakeDailyPractice extends Fake implements DailyPractice {}
