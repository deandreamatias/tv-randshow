import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uni_links/uni_links.dart';

import '../models/tvshow_actions.dart';

@lazySingleton
class AppService {
  int timesOpenLink = 0;
  PackageInfo? _packageInfo;

  Future<String> getVersion() async {
    _packageInfo ??= await PackageInfo.fromPlatform();
    return _packageInfo!.version;
  }

  Future<TvshowActions> initUniLinks() async {
    try {
      final Uri? initialLink = await getInitialUri();
      if (initialLink == null || initialLink.path.isEmpty) {
        debugPrint('$runtimeType Link empty or null');
        return TvshowActions(tvshow: '');
      } else {
        return _parseLink(initialLink);
      }
    } on PlatformException catch (e) {
      return throw PlatformException(
          code: e.code, message: e.message, details: e.details);
    }
  }

  TvshowActions _parseLink(Uri initialLink) {
    if (initialLink.path.contains('getRandomEpisode')) {
      final TvshowActions tvshowActions =
          TvshowActions.fromMap(initialLink.queryParameters);
      timesOpenLink = ++timesOpenLink;
      return tvshowActions;
    } else {
      return TvshowActions(tvshow: '');
    }
  }

  Future<bool> hasStoragePermission() async {
    if (kIsWeb) return true;

    bool status = await Permission.storage.isGranted;
    if (status) return true;
    final permission = await Permission.storage.request();

    return permission.isGranted;
  }

  Future<String> saveFile(String fileName, String json) async {
    return await FileSaver.instance.saveFile(
      fileName,
      Uint8List.fromList(json.codeUnits),
      'json',
      mimeType: MimeType.JSON,
    );
  }
}
