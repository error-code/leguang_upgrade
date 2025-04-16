
import 'package:flutter/material.dart';

import 'leguang_upgrade_dialog.dart';
// import 'leguang_upgrade_platform_interface.dart';
import 'upgrade_entity.dart';
export 'upgrade_entity.dart';

// class LeguangUpgrade {
//   Future<String?> getPlatformVersion() {
//     return LeguangUpgradePlatform.instance.getPlatformVersion();
//   }
// }

class LeguangUpgrade extends StatefulWidget {
  const LeguangUpgrade({
    super.key,
    required this.child,
    this.onCheck,
    this.debug = true
  });
  final Widget child;
  final Future<UpgradeEntity?>Function()? onCheck;
  final bool debug;

  @override
  State<LeguangUpgrade> createState() => _LeguangUpgradeState();
}

class _LeguangUpgradeState extends State<LeguangUpgrade> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkVersion();
  }

  void checkVersion() async{
    if(widget.onCheck==null){
      debugPrint('没有传入检测回调');
      return;
    }
    UpgradeEntity? data = await widget.onCheck?.call();
    if(data==null){
      debugPrint('检测回调没有返回值');
      return;
    }

    // UpgradeEntity data = UpgradeEntity(
    //   title: '有新功能可用',
    //   version: 'V1.2.67',
    //   notes: [
    //     '1、我们改进了交互操作等相关的一些操作希望你每次下单都有好的体验',
    //     '2、我们优化了与物流相关的部分功能你现在下单可以支持更多物流进行配送了',
    //     '2、我们优化了与物流相关的部分功能你现在下单可以支持更多物流进行配送了',
    //     '2、我们优化了与物流相关的部分功能你现在下单可以支持更多物流进行配送了',
    //   ],
    //   downloadUrl: 'https://linlijiangnan-1319477496.cos.ap-nanjing.myqcloud.com/uploads/file/20241231/2024123114262709dc18821.apk'
    // );
    if(!mounted) return;
    showDialog(
      context: context,
      builder: (_){
        return LeguangUpgradeDialog(
          data: data,
        );
      },
      barrierDismissible: false
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if(widget.debug)
          Positioned(
            right: 20,
            bottom: 20,
            child: ElevatedButton(
              onPressed: checkVersion,
              child: const Text('检测更新'),
            ),
          )
      ],
    );
  }
}
