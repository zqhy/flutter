
import 'hy_device_id_platform_interface.dart';

// https://github.com/BestBurning/platform_device_id
// https://github.com/creche-studio/immutable_device_identifier

class HyDeviceId {
  Future<String?> getDeviceId() {
    return HyDeviceIdPlatform.instance.getDeviceId();
  }
}
