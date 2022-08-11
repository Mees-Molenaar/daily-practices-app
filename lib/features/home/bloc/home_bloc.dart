import 'dart:developer';

import 'package:daily_practices_repository/daily_practices_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final DailyPracticesRepository _dailyPracticesRepository;
  final DateTime lastUpdated;

  HomeBloc({
    required DailyPracticesRepository dailyPracticesRepository,
    required this.lastUpdated,
  })  : _dailyPracticesRepository = dailyPracticesRepository,
        super(HomeState(lastUpdated: lastUpdated)) {
    on<HomeSubscriptionRequested>(_onSubscriptionRequested);
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
}
