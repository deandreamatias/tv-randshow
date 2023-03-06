import 'package:stacked/stacked.dart';
import 'package:tv_randshow/core/app/domain/interfaces/i_app_service.dart';
import 'package:tv_randshow/core/app/ioc/locator.dart';
import 'package:tv_randshow/core/io/domain/use_cases/export_tvshows_use_case.dart';

class InfoViewModel extends BaseViewModel {
  final IAppService _appService = locator<IAppService>();
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
