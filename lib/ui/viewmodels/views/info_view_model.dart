import 'package:stacked/stacked.dart';
import 'package:tv_randshow/config/locator.dart';
import 'package:tv_randshow/core/app/data/services/app_service.dart';
import 'package:tv_randshow/core/io/domain/use_cases/export_tvshows_use_case.dart';

class InfoViewModel extends BaseViewModel {
  final AppService _appService = locator<AppService>();
  final ExportTvShowsUseCase _exportTvShowsUseCase =
      locator<ExportTvShowsUseCase>();

  String _version = '-';
  String get version => _version;

  Future<void> getVersion() async {
    _version = await _appService.getVersion();
  }

  Future<void> exportTvshows() async {
    setBusy(true);
    await _exportTvShowsUseCase();
    setBusy(false);
  }
}
