import 'package:daily_practices_api/daily_practices_api.dart';
import 'package:daily_practices_repository/daily_practices_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final DailyPracticesRepository _dailyPracticesRepository;

  HomeBloc({
    required DailyPracticesRepository dailyPracticesRepository,
  })  : _dailyPracticesRepository = dailyPracticesRepository,
        super(const HomeState());
}
