import 'package:tv_randshow/core/app/data/models/pagination_data_model.dart';
import 'package:tv_randshow/core/tvshow/domain/models/result.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_details.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_seasons_details.dart';

abstract class IOnlineRepository {
  Future<PaginationDataModel<Result>> search({
    required String text,
    required int page,
    required String language,
  });
  Future<TvshowDetails> getDetailsTv(String language, int idTv);
  Future<TvshowSeasonsDetails> getDetailsTvSeasons(
    String language,
    int idTv,
    int idSeason,
  );
}
