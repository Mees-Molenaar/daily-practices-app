import 'dart:developer';
import 'dart:math' show Random;

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
    final dailyPractices = _dailyPracticesRepository.getDailyPractices();
    final activePractice = _userPreferencesRepository.getActivePractice();

    await emit.forEach<List<DailyPractice>>(dailyPractices,
        onData: (dailyPractice) => state.copyWith(
              practices: dailyPractice,
              activePractice: activePractice,
            ),
        onError: (_, __) {
          log('Error!');
          return state;
        });
  }

  Future<void> _updateLastUpdated(
      NewDayEvent event, Emitter<HomeState> emit) async {
    final today = DateTime.now();

    var newActivePractice = state.activePractice;

    if (state.practices.length > 1) {
      newActivePractice = _getNewActivePractice(
        state.activePractice,
        state.practices.length,
      );
    }

    _userPreferencesRepository.setLastUpdated(today);
    _userPreferencesRepository.setActivePractice(newActivePractice);

    emit(state.copyWith(
      lastUpdated: today,
      activePractice: newActivePractice,
    ));
  }
}

int _getNewActivePractice(
  int oldPractice,
  int totalPractices,
) {
  var newPractice = 1;

  var rng = Random();

  while (newPractice == oldPractice) {
    var randomNumber =
        rng.nextInt(totalPractices) + 1; //NOTE: This makes zero impossible
    newPractice = randomNumber;
  }

  return newPractice;
}
