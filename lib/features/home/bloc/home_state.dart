part of 'home_bloc.dart';

class HomeState extends Equatable {
  final List<DailyPractice> practices;
  final DateTime lastUpdated;
  final int activePractice;
  const HomeState({
    this.practices = const [],
    required this.lastUpdated,
    this.activePractice = 1,
  });

  @override
  List<Object> get props => [practices, lastUpdated, activePractice];

  HomeState copyWith({
    List<DailyPractice>? practices,
    final DateTime? lastUpdated,
    final int? activePractice,
  }) {
    return HomeState(
      practices: practices ?? this.practices,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      activePractice: activePractice ?? this.activePractice,
    );
  }
}
