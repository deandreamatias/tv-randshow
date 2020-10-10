import 'package:stacked/stacked.dart';
import '../../../config/locator.dart';
import '../../services/app_service.dart';

class InfoViewModel extends BaseViewModel {
  final AppService _appService = locator<AppService>();

  String _version = '-';
  String get version => _version;

  Future<void> getVersion() async {
    _version = await _appService.getVersion();
  }
}
