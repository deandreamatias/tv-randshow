import 'package:stacked/stacked.dart';
import 'package:tv_randshow/config/locator.dart';
import 'package:tv_randshow/core/services/app_service.dart';
import 'package:tv_randshow/core/services/manage_files_service.dart';

class InfoViewModel extends BaseViewModel {
  final AppService _appService = locator<AppService>();
  final ManageFilesService _manageFiles = locator<ManageFilesService>();

  String _version = '-';
  String get version => _version;

  Future<void> getVersion() async {
    _version = await _appService.getVersion();
  }

  Future<void> exportTvshows() async {
    setBusy(true);
    await _manageFiles.saveTvshows();
    setBusy(false);
  }
}
