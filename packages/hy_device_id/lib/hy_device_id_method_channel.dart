import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'hy_device_id_platform_interface.dart';

/// An implementation of [HyDeviceIdPlatform] that uses method channels.
class MethodChannelHyDeviceId extends HyDeviceIdPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('hy_device_id');

  @override
  Future<String?> getDeviceId() async {
    final version = await methodChannel.invokeMethod<String>('getDeviceId');
    return version;
  }
}
