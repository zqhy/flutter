// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html show window;

import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:uuid/uuid.dart';

import 'hy_device_id_platform_interface.dart';

/// A web implementation of the HyDeviceIdPlatform of the HyDeviceId plugin.
class HyDeviceIdWeb extends HyDeviceIdPlatform {
  /// Constructs a HyDeviceIdWeb
  HyDeviceIdWeb();

  static void registerWith(Registrar registrar) {
    HyDeviceIdPlatform.instance = HyDeviceIdWeb();
  }

  /// Returns a [String] containing the version of the platform.
  @override
  Future<String?> getDeviceId() async {
    return const Uuid().v1();
  }
}
