import 'dart:developer';
import 'dart:io';

import 'package:app_installer/app_installer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'upgrade_entity.dart';

class LeguangUpgradeDialog extends StatefulWidget {
  const LeguangUpgradeDialog({
    super.key,
    required this.data,
    this.onError
  });
  final UpgradeEntity data;
  final ValueChanged<dynamic>? onError;

  @override
  State<LeguangUpgradeDialog> createState() => _LeguangUpgradeDialogState();
}

class _LeguangUpgradeDialogState extends State<LeguangUpgradeDialog> {

  bool updating = false;
  bool downloading = false;
  double downloadProgress = 0;

  Future<void> begin() async {
    if(Platform.isIOS){
      if(widget.data.iOSAppId==null){
        debugPrint('未传入iOSAppId');
        return;
      }
      AppInstaller.goStore('', '${widget.data.iOSAppId}');
      return;
    }
    updating = true;
    setState(() {});
    downloadApkHandler(widget.data.downloadUrl,'${(await getDownloadsDirectory())?.path}/leguang.apk');
  }

  void close(){
    Navigator.pop(context);
  }

  // 下载处理
  Future downloadApkHandler(String url, String path) async {
    log('下载地址：$path');
    if (downloading) {
      debugPrint('当前下载状态：下载中, 不能重复下载。');
      return;
    }
    downloading = true;
    try {
      await Dio().download(
        url,
        path,
        options: Options(
          headers: widget.data.headers
        ),
        onReceiveProgress: (int count, int total) {
          if (total == -1) {
            downloadProgress = 0.01;
          } else {
            downloadProgress = count / total.toDouble();
          }
          setState(() {});
          if (downloadProgress == 1) {
            AppInstaller.installApk(path);
            Navigator.pop(context);
          }
        },
      );
    } catch (e) {
      downloadProgress = 0;
      widget.onError?.call(e);
      debugPrint('下载出错：$e');
      // widget.downloadStatusChange?.call(DownloadStatus.error, error: e);
    }
  }

  @override
  Widget build(BuildContext context) {

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.white,
                        Colors.white,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.1,0.2,0.9]
                  ),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)
                  )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: 1.6,
                        child: Image.asset('assets/upgrade_bg.png',package: 'leguang_upgrade',fit: BoxFit.fitWidth,alignment: Alignment.topCenter),
                      ),
                      Positioned(
                        top: 50,
                        left: 20,
                        child: Text.rich(TextSpan(
                            style: const TextStyle(
                                color: Colors.white
                            ),
                            children: [
                              TextSpan(text: '${widget.data.title}\n',style:const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600
                              )),
                              TextSpan(text: '${widget.data.version}',style:const TextStyle(
                                  fontSize: 12,
                                  height: 2
                              )),
                            ]
                        )),
                      ),
                      if(!widget.data.force||!updating)
                        Positioned(
                          right: 8,
                          top: 40,
                          child: InkWell(
                            onTap: close,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(.5),
                                borderRadius: BorderRadius.circular(20)
                              ),
                              padding: const EdgeInsets.all(4),
                              child: const Icon(Icons.close,color: Colors.white,size: 20),
                            ),
                          ),
                        )
                    ],
                  ),
                  Container(
                    height: 150,
                    padding: const EdgeInsets.only(
                        bottom: 20
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(widget.data.notes??'常规更新',style: const TextStyle(
                        height: 1.8,
                      )),
                    ),
                  ),
                  updating?_updateWidget():_buttonWidget()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String get progress{
    return (downloadProgress*100).toStringAsFixed(0);
  }

  Widget _updateWidget(){
    return Container(
      padding:const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 20
      ),
      child: Column(
        children: [
          const Text('正在更新',style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xff01908A)
          )),
          const SizedBox(height: 10),
          Stack(
            children: [
              LinearProgressIndicator(
                value: downloadProgress,
                minHeight: 16,
                backgroundColor:const Color(0xffE6E6E6),
                color:const Color(0xff01908A),
                borderRadius: BorderRadius.circular(10),
                semanticsValue: '11',
                semanticsLabel: '22',
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                child: Text('$progress%',style:const TextStyle(
                  color: Colors.white,
                  fontSize: 12
                ),textAlign: TextAlign.center),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buttonWidget(){
    return Container(
      padding:const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 20
      ),
      child: ElevatedButton(
        onPressed: begin,
        style: const ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Color(0xff01908A)),
          foregroundColor: WidgetStatePropertyAll(Colors.white)
        ),
        child:const Text('立即更新'),
      ),
    );
  }
}
