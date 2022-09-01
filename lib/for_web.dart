import 'dart:html';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget webView(String lihk) => const WebPlatformWebView(
      link: 'https://flutter.dev/',
    );

class WebPlatformWebView extends StatelessWidget {
  final String link;

  const WebPlatformWebView({Key? key, required this.link}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = Random().nextInt.toString();
    // ui.
    // PlatformViewsRegistry
    return Container(
      child: HtmlElementView(viewType: id),
    );
  }
}
