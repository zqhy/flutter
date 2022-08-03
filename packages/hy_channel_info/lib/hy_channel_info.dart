
import 'hy_channel_info_platform_interface.dart';

class HyChannelInfo {
  Future<String?> getChannelInfo() {
    return HyChannelInfoPlatform.instance.getChannelInfo();
  }
}
