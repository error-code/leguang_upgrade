class UpgradeEntity{
  ///[title] 窗口标题
  String? title;
  ///[version] 版本号
  String? version;
  ///[notes] 更新说明
  List<String>? notes;
  ///[downloadUrl] 下载地址
  final String downloadUrl;
  ///[headers] 下载时需要额外传参
  Map<String, dynamic>? headers;
  ///[iOSAppId] 仅支持ios
  String? iOSAppId;
  ///[force] 是否强制更新
  late bool force;

  UpgradeEntity({
    this.title,
    this.version,
    this.notes,
    required this.downloadUrl,
    this.headers,
    this.iOSAppId,
    this.force = false
  });
}