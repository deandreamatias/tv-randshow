import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';
import 'package:tv_randshow/core/tvshow/domain/interfaces/i_online_repository.dart';
import 'package:tv_randshow/core/tvshow/domain/models/query.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_details.dart';
import 'package:tv_randshow/core/tvshow/domain/use_cases/get_local_tvshows_use_case.dart';

@injectable
class GetTvshowDetailsUseCase {
  final GetLocalTvshowsUseCase _getTvshows;
  final IOnlineRepository _onlineRepository;

  const GetTvshowDetailsUseCase(
    this._onlineRepository,
    this._getTvshows,
  );

  Future<TvshowDetails> call(Query query, int idTv) async {
    final tvshows = await _getTvshows();
    if (tvshows.isNotEmpty) {
      final tvshow = tvshows.singleWhereOrNull((element) => element.id == idTv);
      if (tvshow != null) return tvshow;
    }

    return _onlineRepository.getDetailsTv(query, idTv);
  }
}
