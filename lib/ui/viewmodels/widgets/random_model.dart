import 'package:stacked/stacked.dart';

import 'package:tv_randshow/config/locator.dart';
import 'package:tv_randshow/core/tvshow/domain/models/query.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_details.dart';
import 'package:tv_randshow/core/tvshow/domain/use_cases/get_tvshow_details_use_case.dart';

class RandomModel extends BaseViewModel {
  final GetTvshowDetailsUseCase _getTvshowDetailsUseCase =
      locator<GetTvshowDetailsUseCase>();

  TvshowDetails? _tvshowDetails;

  TvshowDetails? get tvshowDetails => _tvshowDetails;

  Future<void> getDetails(int id, String language) async {
    setBusy(true);
    final Query query = Query(language: language);
    _tvshowDetails = await _getTvshowDetailsUseCase(query, id);
    setBusy(false);
  }
}
