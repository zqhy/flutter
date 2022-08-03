import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'hy_channel_info_platform_interface.dart';

/// An implementation of [HyChannelInfoPlatform] that uses method channels.
class MethodChannelHyChannelInfo extends HyChannelInfoPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('hy_channel_info');

  @override
  Future<String?> getChannelInfo() async {
    final version = await methodChannel.invokeMethod<String>('getChannelInfo');
    return version;
  }
}
