import 'dart:ui' as ui;
import 'package:injectable/injectable.dart';
import 'package:tv_randshow/core/streaming/domain/models/streaming_search.dart';
import 'package:tv_randshow/core/streaming/domain/use_cases/get_tvshow_streamings_use_case.dart';
import 'package:tv_randshow/core/tvshow/domain/interfaces/i_local_repository.dart';
import 'package:tv_randshow/core/tvshow/domain/interfaces/i_online_repository.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_details.dart';
import 'package:tv_randshow/ui/shared/helpers/helpers.dart';

@injectable
class AddFavTvshowUseCase {
  final IOnlineRepository _onlineRepository;
  final ILocalRepository _localRepository;
  final GetTvshowStreamingsUseCase _getTvshowStreamingsUseCase;

  const AddFavTvshowUseCase(
    this._onlineRepository,
    this._getTvshowStreamingsUseCase,
    this._localRepository,
  );

  Future<TvshowDetails> call({
    required int idTv,
  }) async {
    TvshowDetails tvshowDetails =
        await _onlineRepository.getDetailsTv(Helpers.getLocale(), idTv);

    final streamings = await _getTvshowStreamingsUseCase(
      StreamingSearch(
        tmdbId: idTv.toString(),
        country: ui.window.locale.countryCode ?? '',
      ),
    );
    tvshowDetails = tvshowDetails.copyWith(streamings: streamings);

    await _localRepository.saveTvshow(tvshowDetails);

    return tvshowDetails;
  }
}
