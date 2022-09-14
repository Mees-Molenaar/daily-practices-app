// ignore_for_file: depend_on_referenced_packages

import 'package:daily_practices_app/features/home/bloc/home_bloc.dart';
import 'package:daily_practices_repository/daily_practices_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_preferences_repository/user_preferences_repository.dart';
import 'package:timezone/timezone.dart' as tz;

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

class PracticesView extends StatefulWidget {
  const PracticesView({Key? key}) : super(key: key);

  @override
  State<PracticesView> createState() => _PracticesViewState();
}

class _PracticesViewState extends State<PracticesView>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      final state = BlocProvider.of<HomeBloc>(context).state;

      final currentDate = tz.TZDateTime.now(tz.local);
      // TODO: Wanneer de tijd van de notificatie verandert kan worden moet dit ook veranderd
      final lastUpdated = tz.TZDateTime.local(
        state.lastUpdated.year,
        state.lastUpdated.month,
        state.lastUpdated.day,
        7,
        0,
        0,
      );
      final daysDifference = currentDate.difference(lastUpdated).inDays;

      if (daysDifference > 0) {
        BlocProvider.of<HomeBloc>(context).add(const NewDayEvent());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Practices'),
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          // TODO: Duplicate code van hierboven dus een Code Smell
          // NOTE: Maar anders werkt het niet wanneer je de app compleet opnieuw start
          // Ook wordt dit nu 2x gechecked, maar de NewDayEvent wordt maar 1x uitgevoerd omdat na 1x update de daysDifference niet groter is dan 0
          final currentDate = tz.TZDateTime.now(tz.local);
          // TODO: Wanneer de tijd van de notificatie verandert kan worden moet dit ook veranderd
          final lastUpdated = tz.TZDateTime.local(
            state.lastUpdated.year,
            state.lastUpdated.month,
            state.lastUpdated.day,
            7,
            0,
            0,
          );
          final daysDifference = currentDate.difference(lastUpdated).inDays;

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
              if (index == state.activePractice) {
                return Card(
                  key: const Key('ActivePractice'),
                  elevation: 3,
                  color: Theme.of(context).colorScheme.primary,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Text(
                        practices[index].id.toString(),
                      ),
                    ),
                    title: Text(
                      practices[index].practice,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              } else {
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
              }
            },
          );
        },
      ),
    );
  }
}
