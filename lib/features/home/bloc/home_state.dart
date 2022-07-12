part of 'home_bloc.dart';

class HomeState extends Equatable {
  final List<DailyPractice> practices;
  const HomeState({
    this.practices = const [],
  });

  @override
  List<Object> get props => [practices];

  HomeState copyWith({
    List<DailyPractice> Function()? practices,
  }) {
    return HomeState(
      practices: practices != null ? practices() : this.practices,
    );
  }
}
