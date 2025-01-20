import 'package:flutter_test/flutter_test.dart';
import 'package:leguang_upgrade/leguang_upgrade.dart';
import 'package:leguang_upgrade/leguang_upgrade_platform_interface.dart';
import 'package:leguang_upgrade/leguang_upgrade_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockLeguangUpgradePlatform
    with MockPlatformInterfaceMixin
    implements LeguangUpgradePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final LeguangUpgradePlatform initialPlatform = LeguangUpgradePlatform.instance;

  test('$MethodChannelLeguangUpgrade is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelLeguangUpgrade>());
  });

  test('getPlatformVersion', () async {
    LeguangUpgrade leguangUpgradePlugin = LeguangUpgrade();
    MockLeguangUpgradePlatform fakePlatform = MockLeguangUpgradePlatform();
    LeguangUpgradePlatform.instance = fakePlatform;

    expect(await leguangUpgradePlugin.getPlatformVersion(), '42');
  });
}
