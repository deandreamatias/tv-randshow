import 'package:tv_randshow/core/tvshow/domain/models/search.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_details.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_seasons_details.dart';

abstract class IOnlineRepository {
  Future<Search> search({
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
