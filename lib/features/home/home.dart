import 'package:flutter/material.dart';

class PracticesList extends StatefulWidget {
  const PracticesList({Key? key}) : super(key: key);

  @override
  State<PracticesList> createState() => _PracticesListState();
}

class _PracticesListState extends State<PracticesList> {
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Practices'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        controller: controller,
        itemCount: 26,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text('Entry $index'),
          );
        },
      ),
    );
  }
}
