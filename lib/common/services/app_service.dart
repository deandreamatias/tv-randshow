import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tv_randshow/common/interfaces/i_app_service.dart';

@LazySingleton(as: IAppService)
class AppService implements IAppService {
  PackageInfo? _packageInfo;

  @override
  Future<String> getVersion() async {
    _packageInfo ??= await PackageInfo.fromPlatform();

    return _packageInfo?.version ?? '-';
  }
}
