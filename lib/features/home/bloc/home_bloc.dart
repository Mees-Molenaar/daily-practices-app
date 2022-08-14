import 'dart:developer';

import 'package:daily_practices_repository/daily_practices_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_preferences_repository/user_preferences_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final DailyPracticesRepository _dailyPracticesRepository;
  final UserPreferencesRepository _userPreferencesRepository;

  HomeBloc({
    required DailyPracticesRepository dailyPracticesRepository,
    required UserPreferencesRepository userPreferencesRepository,
  })  : _dailyPracticesRepository = dailyPracticesRepository,
        _userPreferencesRepository = userPreferencesRepository,
        super(HomeState(
            lastUpdated: userPreferencesRepository.getLastUpdated())) {
    on<HomeSubscriptionRequested>(_onSubscriptionRequested);
    on<NewDayEvent>(_updateLastUpdated);
  }

  Future<void> _onSubscriptionRequested(
    HomeSubscriptionRequested event,
    Emitter<HomeState> emit,
  ) async {
    await emit.forEach<List<DailyPractice>>(
        _dailyPracticesRepository.getDailyPractices(),
        onData: (dailyPractice) => state.copyWith(
              practices: dailyPractice,
            ),
        onError: (_, __) {
          log('Error!');
          return state;
        });
  }

  Future<void> _updateLastUpdated(
    NewDayEvent event,
    Emitter<HomeState> emit,
  ) async {
    final today = DateTime.now();

    _userPreferencesRepository.setLastUpdated(today);

    emit(state.copyWith(
      lastUpdated: today,
    ));
  }
}
