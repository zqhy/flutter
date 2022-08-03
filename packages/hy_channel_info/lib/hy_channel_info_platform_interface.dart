import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'hy_channel_info_method_channel.dart';

abstract class HyChannelInfoPlatform extends PlatformInterface {
  /// Constructs a HyChannelInfoPlatform.
  HyChannelInfoPlatform() : super(token: _token);

  static final Object _token = Object();

  static HyChannelInfoPlatform _instance = MethodChannelHyChannelInfo();

  /// The default instance of [HyChannelInfoPlatform] to use.
  ///
  /// Defaults to [MethodChannelHyChannelInfo].
  static HyChannelInfoPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [HyChannelInfoPlatform] when
  /// they register themselves.
  static set instance(HyChannelInfoPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getChannelInfo() {
    throw UnimplementedError('channelInfo() has not been implemented.');
  }
}
