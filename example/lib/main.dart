import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:leguang_upgrade/leguang_upgrade.dart';
import 'package:leguang_upgrade/upgrade_entity.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  // final _leguangUpgradePlugin = LeguangUpgrade();
  //
  @override
  void initState() {
    super.initState();
    // initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  // Future<void> initPlatformState() async {
  //   String platformVersion;
  //   // Platform messages may fail, so we use a try/catch PlatformException.
  //   // We also handle the message potentially returning null.
  //   try {
  //     platformVersion =
  //         await _leguangUpgradePlugin.getPlatformVersion() ?? 'Unknown platform version';
  //   } on PlatformException {
  //     platformVersion = 'Failed to get platform version.';
  //   }
  //
  //   // If the widget was removed from the tree while the asynchronous platform
  //   // message was in flight, we want to discard the reply rather than calling
  //   // setState to update our non-existent appearance.
  //   if (!mounted) return;
  //
  //   setState(() {
  //     _platformVersion = platformVersion;
  //   });
  // }

  Future<UpgradeEntity> checkVersion() async{
    await Future.delayed(const Duration(milliseconds: 500));
    UpgradeEntity data = UpgradeEntity(
      title: '有新功能可用',
      version: 'V1.2.67',
      notes: '1、我们改进了交互操作等相关的一些操作希望你每次下单都有好的体验\n'
        '2、我们优化了与物流相关的部分功能你现在下单可以支持更多物流进行配送了\n'
        '2、我们优化了与物流相关的部分功能你现在下单可以支持更多物流进行配送了\n'
        '2、我们优化了与物流相关的部分功能你现在下单可以支持更多物流进行配送了\n',
      downloadUrl: 'https://linlijiangnan-1319477496.cos.ap-nanjing.myqcloud.com/uploads/file/20241231/2024123114262709dc18821.apk',
      headers: {
        'referer':'app.linlijiangnan.com'
      },
      force: false
    );
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: false
      ),
      home: LeguangUpgrade(
        onCheck: checkVersion,
        debug: true,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: Center(
            child: Text('Running on: $_platformVersion\n'),
          ),
        ),
      ),
    );
  }
}
