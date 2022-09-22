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
    try {
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
    } catch (e) {
      log(e.toString());
    }
  }
}

// Indexing starts at 0 while using the listbuilder in home.dart
// Therefore, the newPractice that is returned should be 0 - 25 (that is 26 entries as in practices_data.dart)
int _getNewActivePractice(
  int oldPractice,
  int totalPractices,
) {
  var rng = Random();
  //NOTE: rng.nextInt(0) given as error, this prevents it
  if (totalPractices == 0) {
    totalPractices = 1;
  }
  var newPractice = rng.nextInt(totalPractices);

  while (newPractice == oldPractice) {
    var randomNumber = rng.nextInt(totalPractices);
    newPractice = randomNumber;
  }

  return newPractice;
}
