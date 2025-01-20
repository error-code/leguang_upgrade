import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'leguang_upgrade_method_channel.dart';

abstract class LeguangUpgradePlatform extends PlatformInterface {
  /// Constructs a LeguangUpgradePlatform.
  LeguangUpgradePlatform() : super(token: _token);

  static final Object _token = Object();

  static LeguangUpgradePlatform _instance = MethodChannelLeguangUpgrade();

  /// The default instance of [LeguangUpgradePlatform] to use.
  ///
  /// Defaults to [MethodChannelLeguangUpgrade].
  static LeguangUpgradePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [LeguangUpgradePlatform] when
  /// they register themselves.
  static set instance(LeguangUpgradePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
