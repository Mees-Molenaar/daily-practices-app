import 'package:daily_practices_app/features/home/bloc/home_bloc.dart';
import 'package:daily_practices_repository/daily_practices_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_preferences_repository/user_preferences_repository.dart';

class PracticesPage extends StatelessWidget {
  const PracticesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        dailyPracticesRepository: context.read<DailyPracticesRepository>(),
        userPreferencesRepository: context.read<UserPreferencesRepository>(),
      )..add(const HomeSubscriptionRequested()),
      child: const PracticesView(),
    );
  }
}

class PracticesView extends StatelessWidget {
  const PracticesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Practices'),
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          final currentDate = DateTime.now();
          final daysDifference =
              currentDate.difference(state.lastUpdated).inDays;

          if (daysDifference > 0) {
            BlocProvider.of<HomeBloc>(context).add(const NewDayEvent());
          }
        },
        builder: (context, state) {
          final practices = state.practices;

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: practices.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                elevation: 3,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: Text(practices[index].id.toString()),
                  ),
                  title: Text(practices[index].practice),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
