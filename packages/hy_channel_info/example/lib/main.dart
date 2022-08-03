import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:hy_channel_info/hy_channel_info.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _channelInfo = 'Unknown';
  final _hyChannelInfoPlugin = HyChannelInfo();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String channelInfo;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      channelInfo =
          await _hyChannelInfoPlugin.getChannelInfo() ?? 'Unknown channel info';
    } on PlatformException {
      channelInfo = 'Failed to get channel info.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _channelInfo = channelInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Get channel info'),
        ),
        body: Column(
          children: [
            OutlinedButton(onPressed: initPlatformState, child: const Text("get channel info")),
            Text('channel info: \n$_channelInfo'),
          ],
        )
      ),
    );
  }
}
