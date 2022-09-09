import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'people.dart';

class MyRouter {
  static FluroRouter router = FluroRouter();

  static final Handler _initializeHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return const MyHomePage();
  });

  static final Handler _peopleHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return const PeoplePage();
  });

  static void setupRouter() {
    router.define(
      MyHomePage.routeName,
      handler: _initializeHandler,
    );
    router.define(
      PeoplePage.routeName,
      handler: _peopleHandler,
    );
  }
}
