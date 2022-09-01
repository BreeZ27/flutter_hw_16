import 'package:flutter_hw_16/app_platform.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

Widget webView(String link) => AppPlatform.isMobile
    ? WebView(
        initialUrl: link,
      )
    : HyperLink(link: link);

class HyperLink extends StatelessWidget {
  final String link;
  const HyperLink({Key? key, required this.link}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: Text(link),
      ),
    );
  }
}
