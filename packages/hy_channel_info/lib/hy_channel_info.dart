import 'dart:async';

import 'package:flutter/services.dart';

class HyChannelInfo {
  static const MethodChannel _channel =
      const MethodChannel('hy_channel_info');

  static Future<String> get channelInfo async {
    final String version = await _channel.invokeMethod('getChannelInfo');
    return version;
  }
}
