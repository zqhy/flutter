import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hy_channel_info/hy_channel_info_method_channel.dart';

void main() {
  MethodChannelHyChannelInfo platform = MethodChannelHyChannelInfo();
  const MethodChannel channel = MethodChannel('hy_channel_info');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getChannelInfo', () async {
    expect(await platform.getChannelInfo(), '42');
  });
}
