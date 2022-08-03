import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:hy_device_id/hy_device_id.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _deviceId = 'Unknown';
  final _hyDeviceIdPlugin = HyDeviceId();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String deviceId;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      deviceId = await _hyDeviceIdPlugin.getDeviceId() ?? 'Unknown device Id';
    } on PlatformException {
      deviceId = 'Failed to get device Id.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    print("获取到 device Id：$deviceId");

    setState(() {
      _deviceId = deviceId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Get device Id'),
        ),
        body: Column(
          children: [
            OutlinedButton(onPressed: initPlatformState, child: const Text("get device Id")),
            Text('device Id: \n$_deviceId'),
          ],
        ),
      ),
    );
  }
}
