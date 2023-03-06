import 'package:stacked/stacked.dart';
import 'package:tv_randshow/config/locator.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_details.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_result.dart';
import 'package:tv_randshow/core/tvshow/domain/use_cases/get_random_episode_use_case.dart';

class LoadingViewModel extends BaseViewModel {
  final GetRandomEpisodeUseCase _getRandomEpisodeUseCase =
      locator<GetRandomEpisodeUseCase>();

  TvshowResult? _tvshowResult;
  bool _canNavigate = false;

  TvshowResult? get tvshowResult => _tvshowResult;
  bool get canNavigate => _canNavigate;

  Future<void> sortRandomEpisode(
    TvshowDetails tvshowDetails,
    String language,
  ) async {
    setBusy(true);
    _tvshowResult = await _getRandomEpisodeUseCase(
      tvshowDetails: tvshowDetails,
      language: language,
    );
    _canNavigate = _tvshowResult != null &&
        _tvshowResult!.randomEpisode >= 0 &&
        _tvshowResult!.randomSeason >= 0;
    setBusy(false);
  }
}
