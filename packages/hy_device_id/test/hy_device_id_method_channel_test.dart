import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hy_device_id/hy_device_id_method_channel.dart';

void main() {
  MethodChannelHyDeviceId platform = MethodChannelHyDeviceId();
  const MethodChannel channel = MethodChannel('hy_device_id');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getDeviceId', () async {
    expect(await platform.getDeviceId(), '42');
  });
}
