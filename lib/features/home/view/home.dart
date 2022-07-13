import 'package:daily_practices_app/features/home/bloc/home_bloc.dart';
import 'package:daily_practices_repository/daily_practices_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PracticesPage extends StatelessWidget {
  const PracticesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        dailyPracticesRepository: context.read<DailyPracticesRepository>(),
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
      body: BlocBuilder<HomeBloc, HomeState>(
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
