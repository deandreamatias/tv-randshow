import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';
import 'package:tv_randshow/core/tvshow/domain/interfaces/i_online_repository.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_details.dart';
import 'package:tv_randshow/core/tvshow/domain/use_cases/get_local_tvshows_use_case.dart';
import 'package:tv_randshow/ui/shared/helpers/helpers.dart';

@injectable
class GetTvshowDetailsUseCase {
  final GetLocalTvshowsUseCase _getLocalTvshows;
  final IOnlineRepository _onlineRepository;

  const GetTvshowDetailsUseCase(
    this._onlineRepository,
    this._getLocalTvshows,
  );

  Future<TvshowDetails> call(int idTv) async {
    final tvshows = await _getLocalTvshows();
    if (tvshows.isNotEmpty) {
      final tvshow = tvshows.singleWhereOrNull((element) => element.id == idTv);
      if (tvshow != null) return tvshow;
    }

    return _onlineRepository.getDetailsTv(Helpers.getLocale(), idTv);
  }
}
