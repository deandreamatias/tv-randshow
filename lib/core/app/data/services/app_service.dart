import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tv_randshow/core/app/domain/interfaces/i_app_service.dart';
import 'package:tv_randshow/core/app/domain/models/tvshow_actions.dart';
import 'package:uni_links/uni_links.dart';

@LazySingleton(as: IAppService)
class AppService implements IAppService {
  PackageInfo? _packageInfo;

  @override
  Future<String> getVersion() async {
    _packageInfo ??= await PackageInfo.fromPlatform();
    return _packageInfo!.version;
  }

  @override
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
      throw PlatformException(
        code: e.code,
        message: e.message,
        details: e.details,
      );
    }
  }

  TvshowActions _parseLink(Uri initialLink) {
    if (!initialLink.path.contains('getRandomEpisode')) {
      final TvshowActions tvshowActions =
          TvshowActions.fromMap(initialLink.queryParameters);
      return tvshowActions;
    }
    return TvshowActions(tvshow: '');
  }
}
