import 'package:flutter_test/flutter_test.dart';
import 'package:hy_device_id/hy_device_id.dart';
import 'package:hy_device_id/hy_device_id_platform_interface.dart';
import 'package:hy_device_id/hy_device_id_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockHyDeviceIdPlatform 
    with MockPlatformInterfaceMixin
    implements HyDeviceIdPlatform {

  @override
  Future<String?> getDeviceId() => Future.value('42');
}

void main() {
  final HyDeviceIdPlatform initialPlatform = HyDeviceIdPlatform.instance;

  test('$MethodChannelHyDeviceId is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelHyDeviceId>());
  });

  test('getDeviceId', () async {
    HyDeviceId hyDeviceIdPlugin = HyDeviceId();
    MockHyDeviceIdPlatform fakePlatform = MockHyDeviceIdPlatform();
    HyDeviceIdPlatform.instance = fakePlatform;
  
    expect(await hyDeviceIdPlugin.getDeviceId(), '42');
  });
}
