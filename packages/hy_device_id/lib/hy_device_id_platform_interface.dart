import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'hy_device_id_method_channel.dart';

abstract class HyDeviceIdPlatform extends PlatformInterface {
  /// Constructs a HyDeviceIdPlatform.
  HyDeviceIdPlatform() : super(token: _token);

  static final Object _token = Object();

  static HyDeviceIdPlatform _instance = MethodChannelHyDeviceId();

  /// The default instance of [HyDeviceIdPlatform] to use.
  ///
  /// Defaults to [MethodChannelHyDeviceId].
  static HyDeviceIdPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [HyDeviceIdPlatform] when
  /// they register themselves.
  static set instance(HyDeviceIdPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getDeviceId() {
    throw UnimplementedError('deviceId() has not been implemented.');
  }
}
