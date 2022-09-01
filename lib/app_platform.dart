import 'dart:io';

import 'package:flutter/foundation.dart';

class AppPlatform {
  static const Map<String, CustomPlatform> _platformMap = {
    'linux': CustomPlatform.linux,
    'macos': CustomPlatform.macos,
    'windows': CustomPlatform.windows,
    'android': CustomPlatform.android,
    'ios': CustomPlatform.ios,
  };

  static CustomPlatform _getPlatform() {
    if (kIsWeb) {
      return CustomPlatform.web;
    }

    return _platformMap[Platform.operatingSystem] ?? CustomPlatform.undefind;
  }

  static CustomPlatform get platform => _getPlatform();

  static bool get isMobile =>
      platform == CustomPlatform.ios || platform == CustomPlatform.android;
}

enum CustomPlatform {
  linux,
  macos,
  windows,
  android,
  ios,
  web,
  undefind,
}
