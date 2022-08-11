part of 'home_bloc.dart';

class HomeState extends Equatable {
  final List<DailyPractice> practices;
  final DateTime lastUpdated;
  const HomeState({
    this.practices = const [],
    required this.lastUpdated,
  });

  @override
  List<Object> get props => [practices];

  HomeState copyWith({
    List<DailyPractice>? practices,
    final DateTime? lastUpdated,
  }) {
    return HomeState(
      practices: practices ?? this.practices,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}
