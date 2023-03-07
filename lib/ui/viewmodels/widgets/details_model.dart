import 'package:stacked/stacked.dart';

import 'package:tv_randshow/core/app/ioc/locator.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_details.dart';
import 'package:tv_randshow/core/tvshow/domain/use_cases/get_tvshow_details_use_case.dart';

class DetailsModel extends BaseViewModel {
  final GetTvshowDetailsUseCase _getTvshowDetailsUseCase =
      locator<GetTvshowDetailsUseCase>();

  TvshowDetails? tvshowDetails;

  Future<void> getDetails(int id, String language) async {
    setBusy(true);
    tvshowDetails = await _getTvshowDetailsUseCase(language, id);
    setBusy(false);
  }
}