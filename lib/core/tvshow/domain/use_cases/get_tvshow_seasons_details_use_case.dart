import 'package:injectable/injectable.dart';
import 'package:tv_randshow/core/tvshow/domain/interfaces/i_online_repository.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_seasons_details.dart';
import 'package:tv_randshow/ui/shared/helpers/helpers.dart';

@injectable
class GetTvshowSeasonsDetailsUseCase {
  final IOnlineRepository _onlineRepository;

  const GetTvshowSeasonsDetailsUseCase(this._onlineRepository);

  Future<TvshowSeasonsDetails> call({required int idTv, required int season}) {
    return _onlineRepository.getDetailsTvSeasons(
      Helpers.getLocale(),
      idTv,
      season,
    );
  }
}
