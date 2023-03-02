import 'package:tv_randshow/core/tvshow/domain/models/query.dart';
import 'package:tv_randshow/core/tvshow/domain/models/search.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_details.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_seasons_details.dart';

abstract class ITvshowRepository {
  Future<Search> search(Query query);
  Future<TvshowDetails> getDetailsTv(Query query, int idTv);
  Future<TvshowSeasonsDetails> getDetailsTvSeasons(
    Query query,
    int idTv,
    int idSeason,
  );
}
