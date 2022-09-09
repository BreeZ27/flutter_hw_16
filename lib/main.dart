import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hw_16/app_platform.dart';
import 'package:flutter_hw_16/fluro_router.dart';
import 'package:flutter_hw_16/people.dart';
import 'package:http/http.dart' as http;

import 'mock_web_view.dart'
    if (dart.library.io) 'not_web.dart'
    if (dart.library.html) 'for_web.dart';

void main() {
  MyRouter.setupRouter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: MyRouter.router.generator,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  static const String routeName = '/';
  final String title = 'Home';

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _htmlText = '';
  String _htmlHeader = '';
  String _htmlResp = '';

  Future<void> getPage() async {
    final res = await http.get(Uri.parse('https://flutter.dev'));
    setState(
      () {
        _htmlText = res.body.toString();
        _htmlHeader = _htmlText
            .split('<title>')[1]
            .split('</title>')[0]
            .replaceAll('\n', '')
            .trimLeft()
            .trimRight();
        _htmlResp = res.headers.toString();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          Expanded(child: webView('https://flutter.dev')),
          // _htmlText == ''
          //     ? const Expanded(
          //         child: Center(
          //           child: Text('Страница не загружена'),
          //         ),
          //       )
          //     : Expanded(
          //         child: Container(
          //           decoration: BoxDecoration(
          //             color: Colors.grey[200],
          //             borderRadius: BorderRadius.circular(10),
          //           ),
          //           padding: const EdgeInsets.all(10),
          //           margin: const EdgeInsets.only(bottom: 8),
          //           child: SingleChildScrollView(
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Text(
          //                   _htmlHeader,
          //                   textAlign: TextAlign.start,
          //                   style: const TextStyle(
          //                     fontSize: 16,
          //                     fontWeight: FontWeight.w500,
          //                   ),
          //                 ),
          //                 const Text('CORS headers: none'),
          //                 Text(_htmlText),
          //               ],
          //             ),
          //           ),
          //         ),
          //       ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[400],
                    ),
                    child: const Text('https://flutter.dev'),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[400],
                  ),
                  child: Text('Work on ${AppPlatform.platform.name}'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () async {
                    await getPage();
                  },
                  child: const Text('Загрузить'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          const FlutterLogo(
            size: 50,
          ),
          const Spacer(),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Navigator.pushNamed(context, MyHomePage.routeName);
            },
          ),
          const Divider(
            thickness: 1,
          ),
          ListTile(
            title: const Text('People'),
            onTap: () {
              Navigator.pushNamed(context, PeoplePage.routeName);
            },
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
