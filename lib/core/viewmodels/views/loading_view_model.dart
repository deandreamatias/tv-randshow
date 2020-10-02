import 'package:stacked/stacked.dart';

import '../../../config/locator.dart';
import '../../models/tvshow_details.dart';
import '../../models/tvshow_result.dart';
import '../../services/random_service.dart';

class LoadingViewModel extends BaseViewModel {
  final RandomService _randomService = locator<RandomService>();

  TvshowResult _tvshowResult;
  bool _canNavigate = false;

  TvshowResult get tvshowResult => _tvshowResult;
  bool get canNavigate => _canNavigate;

  Future<void> sortRandomEpisode(
      TvshowDetails tvshowDetails, String language) async {
    setBusy(true);
    _tvshowResult = await _randomService.randomEpisode(tvshowDetails, language);
    _canNavigate = _tvshowResult != null &&
        _tvshowResult.randomEpisode >= 0 &&
        _tvshowResult.randomSeason >= 0;
    setBusy(false);
  }
}
