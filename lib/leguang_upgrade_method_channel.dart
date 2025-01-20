import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'leguang_upgrade_platform_interface.dart';

/// An implementation of [LeguangUpgradePlatform] that uses method channels.
class MethodChannelLeguangUpgrade extends LeguangUpgradePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('leguang_upgrade');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
