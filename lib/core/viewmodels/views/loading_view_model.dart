import 'package:flutter/widgets.dart';

import 'package:tv_randshow/core/models/tvshow_details.dart';
import 'package:tv_randshow/core/models/tvshow_result.dart';
import 'package:tv_randshow/core/services/random_service.dart';
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
