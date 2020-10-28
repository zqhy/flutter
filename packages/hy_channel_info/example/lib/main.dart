import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:hy_channel_info/hy_channel_info.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _channelInfo = 'Unknown';

  @override
  void initState() {
    super.initState();
    initChannelState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initChannelState() async {
    String channelInfo;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      channelInfo = await HyChannelInfo.channelInfo;
    } on PlatformException {
      channelInfo = 'Failed to get platform version.';
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
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_channelInfo\n'),
        ),
      ),
    );
  }
}
