import 'package:tv_randshow/core/models/query.dart';
import 'package:tv_randshow/core/models/search.dart';
import 'package:tv_randshow/core/models/tvshow_details.dart';
import 'package:tv_randshow/core/models/tvshow_seasons_details.dart';

abstract class ITvshowRepository {
  Future<Search> search(Query query);
  Future<TvshowDetails> getDetailsTv(Query query, int idTv);
  Future<TvshowSeasonsDetails> getDetailsTvSeasons(
    Query query,
    int idTv,
    int idSeason,
  );
}
