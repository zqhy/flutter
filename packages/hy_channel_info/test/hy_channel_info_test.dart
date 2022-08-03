import 'package:flutter_test/flutter_test.dart';
import 'package:hy_channel_info/hy_channel_info.dart';
import 'package:hy_channel_info/hy_channel_info_platform_interface.dart';
import 'package:hy_channel_info/hy_channel_info_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockHyChannelInfoPlatform 
    with MockPlatformInterfaceMixin
    implements HyChannelInfoPlatform {

  @override
  Future<String?> getChannelInfo() => Future.value('42');
}

void main() {
  final HyChannelInfoPlatform initialPlatform = HyChannelInfoPlatform.instance;

  test('$MethodChannelHyChannelInfo is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelHyChannelInfo>());
  });

  test('getChannelInfo', () async {
    HyChannelInfo hyChannelInfoPlugin = HyChannelInfo();
    MockHyChannelInfoPlatform fakePlatform = MockHyChannelInfoPlatform();
    HyChannelInfoPlatform.instance = fakePlatform;
  
    expect(await hyChannelInfoPlugin.getChannelInfo(), '42');
  });
}
