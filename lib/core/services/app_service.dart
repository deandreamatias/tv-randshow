import 'package:injectable/injectable.dart';
import 'package:package_info/package_info.dart';

@lazySingleton
class AppService {
  PackageInfo _packageInfo;

  Future<String> getVersion() async {
    _packageInfo ??= await PackageInfo.fromPlatform();
    return _packageInfo.version;
  }
}
