import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:popover/popover.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hw_16/main.dart';

class PeoplePage extends StatefulWidget {
  const PeoplePage({Key? key}) : super(key: key);
  static const String routeName = '/people';

  @override
  State<PeoplePage> createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> {
  Map people = {};

  Future<void> readJson() async {
    final String answer = await rootBundle.loadString('assets/people.json');
    var data = await json.decode(answer);
    people.addAll(data);
    setState(() {});
  }

  @override
  void initState() {
    readJson();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width <= 720) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('People'),
        ),
        drawer: const MyDrawer(),
        body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: people.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return const ActionsMenu();
                  },
                );
              },
              child: PersonCard(
                name: people.values.toList()[index]['name'],
                surname: people.values.toList()[index]['surname'],
              ),
            );
          },
        ),
      );
    } else {
      return SafeArea(
        child: Scaffold(
            body: Row(
          children: [
            const Expanded(child: MyDrawer()),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ...people.values.map(
                      (e) => Builder(builder: (context) {
                        return GestureDetector(
                          onTap: () {
                            // print('Popover was popped!');
                            showPopover(
                              context: context,
                              transitionDuration:
                                  const Duration(milliseconds: 150),
                              bodyBuilder: (context) => Container(
                                decoration: BoxDecoration(color: Colors.amber),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 20,
                                      child:
                                          const Center(child: Text('Entry A')),
                                    ),
                                    const Divider(),
                                    Container(
                                      height: 20,
                                      child:
                                          const Center(child: Text('Entry B')),
                                    ),
                                    const Divider(),
                                    Container(
                                      height: 20,
                                      child:
                                          const Center(child: Text('Entry C')),
                                    )
                                  ],
                                ),
                              ),
                              onPop: () => print('Popover was popped!'),
                              // direction: PopoverDirection.top,
                              width: 200,
                              height: 150,
                              arrowHeight: 15,
                              arrowWidth: 30,
                            );
                          },
                          child: BigPersonCard(
                            name: e['name'],
                            surname: e['surname'],
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              // child: GridView.builder(
              //   shrinkWrap: false,
              //   itemCount: people.length,
              //   padding: const EdgeInsets.all(8),
              //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 2,
              //       // childAspectRatio: 4,
              //       mainAxisSpacing: 8,
              //       crossAxisSpacing: 8),
              //   itemBuilder: (context, index) {
              //     return GestureDetector(
              //       onTap: () {
              //         print('Popover was popped!');
              //         // showPopover(
              //         //   context: context,
              //         //   // transitionDuration: const Duration(milliseconds: 150),
              //         //   bodyBuilder: (context) => Column(
              //         //     children: [
              //         //       // Text('data'),
              //         //     ],
              //         //   ),
              //         //   // onPop: () => print('Popover was popped!'),
              //         //   // direction: PopoverDirection.top,
              //         //   // width: 200,
              //         //   // height: 150,
              //         //   // arrowHeight: 15,
              //         //   // arrowWidth: 30,
              //         // );
              //       },
              //       child: BigPersonCard(
              //         name: people.values.toList()[index]['name'],
              //         surname: people.values.toList()[index]['surname'],
              //       ),
              //     );
              //   },
              // ),
            ),
          ],
        )),
      );
    }
  }
}

class PersonCard extends StatelessWidget {
  final String name;
  final String surname;
  const PersonCard({
    Key? key,
    required this.name,
    required this.surname,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 100),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: personTextStyle,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  height: 1,
                  color: Colors.black,
                ),
                Text(
                  surname,
                  style: personTextStyle,
                ),
              ],
            ),
          ),
          const Spacer(),
          const FlutterLogo(
            size: 50,
          )
        ],
      ),
    );
  }
}

class BigPersonCard extends StatelessWidget {
  final String name;
  final String surname;
  const BigPersonCard({
    Key? key,
    required this.name,
    required this.surname,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      constraints: const BoxConstraints(maxWidth: 250),
      // width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          const FlutterLogo(
            size: 120,
          ),
          const Spacer(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: personTextStyle,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  height: 1,
                  color: Colors.black,
                ),
                Text(
                  surname,
                  style: personTextStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

TextStyle personTextStyle = const TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w600,
);

class ActionsMenu extends StatelessWidget {
  const ActionsMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Column(
        children: [
          ListTile(
            title: const Text('Профиль'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Divider(thickness: 1),
          ListTile(
            title: const Text('Друзья'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Divider(thickness: 1),
          ListTile(
            title: const Text('Отчёт'),
            onTap: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
