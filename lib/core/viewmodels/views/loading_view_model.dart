import 'package:flutter/widgets.dart';

import '../../models/tvshow_details.dart';
import '../../models/tvshow_result.dart';
import '../../services/random_service.dart';
import '../base_model.dart';

class LoadingViewModel extends BaseModel {
  LoadingViewModel({
    @required RandomService randomService,
  }) : _randomService = randomService;
  final RandomService _randomService;

  Future<TvshowResult> sortRandomEpisode(
      TvshowDetails tvshowDetails, String language) async {
    setBusy(true);
    final TvshowResult tvshowResult =
        await _randomService.randomEpisode(tvshowDetails, language);
    setBusy(false);
    return tvshowResult;
  }
}
