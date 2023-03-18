import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tv_randshow/common/interfaces/i_app_service.dart';
import 'package:tv_randshow/common/models/tvshow_actions.dart';
import 'package:uni_links/uni_links.dart';

@LazySingleton(as: IAppService)
class AppService implements IAppService {
  PackageInfo? _packageInfo;

  @override
  Future<String> getVersion() async {
    _packageInfo ??= await PackageInfo.fromPlatform();

    return _packageInfo?.version ?? '-';
  }

  @override
  Future<TvshowActions> initUniLinks() async {
    final Uri? initialLink = await getInitialUri();
    if (initialLink == null || initialLink.path.isEmpty) {
      debugPrint('$runtimeType Link empty or null');

      return TvshowActions(tvshow: '');
    }

    return _parseLink(initialLink);
  }

  TvshowActions _parseLink(Uri initialLink) {
    if (initialLink.path.contains('getRandomEpisode')) {
      return TvshowActions.fromMap(initialLink.queryParameters);
    }

    return TvshowActions(tvshow: '');
  }
}
