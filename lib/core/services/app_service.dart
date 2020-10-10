import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info/package_info.dart';
import 'package:uni_links/uni_links.dart';

import '../models/tvshow_actions.dart';

@lazySingleton
class AppService {
  PackageInfo _packageInfo;

  Future<String> getVersion() async {
    _packageInfo ??= await PackageInfo.fromPlatform();
    return _packageInfo.version;
  }

  Future<TvshowActions> initUniLinks() async {
    try {
      final Uri initialLink = await getInitialUri();
      if (initialLink == null || initialLink.path.isEmpty) {
        debugPrint('$runtimeType Link empty or null');
        return TvshowActions(tvshow: '');
      } else {
        return initialLink.path.contains('getRandomEpisode')
            ? TvshowActions.fromMap(initialLink.queryParameters)
            : TvshowActions(tvshow: '');
      }
    } on PlatformException catch (e) {
      return throw PlatformException(
          code: e.code, message: e.message, details: e.details);
    }
  }
}
