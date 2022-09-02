import 'package:flutter/material.dart';
import 'package:flutter_hw_16/main.dart';

class PeoplePage extends StatefulWidget {
  const PeoplePage({Key? key}) : super(key: key);
  static const String routeName = '/people';

  @override
  State<PeoplePage> createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('People'),
      ),
      drawer: const MyDrawer(),
      body: Container(),
    );
  }
}
