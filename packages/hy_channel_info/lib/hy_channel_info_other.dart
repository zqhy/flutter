// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html show window;

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'hy_channel_info_platform_interface.dart';

/// A web implementation of the HyChannelInfoPlatform of the HyChannelInfo plugin.
class HyChannelInfoOther extends HyChannelInfoPlatform {
  /// Constructs a HyChannelInfoWeb
  HyChannelInfoOther();

  static void registerWith(Registrar registrar) {
    HyChannelInfoPlatform.instance = HyChannelInfoOther();
  }

  /// Returns a [String] containing the version of the platform.
  @override
  Future<String?> getChannelInfo() async {
    return null;
  }
}
