import 'package:stacked/stacked.dart';
import '../../../config/locator.dart';
import '../../services/app_service.dart';
import '../../services/manage_files.dart';

class InfoViewModel extends BaseViewModel {
  final AppService _appService = locator<AppService>();
  final ManageFiles _manageFiles = locator<ManageFiles>();

  String _version = '-';
  String get version => _version;

  Future<void> getVersion() async {
    _version = await _appService.getVersion();
  }

  Future<void> exportTvshows() async {
    setBusy(true);
    await _manageFiles.saveFile();
    setBusy(false);
  }
}
