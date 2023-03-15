import 'package:tv_randshow/core/tvshow/domain/models/tvshow_details.dart';

abstract class ISecondaryLocalRepository {
  Future<bool> saveTvshows(List<TvshowDetails> tvshows);
  Future<List<TvshowDetails>> getTvshows();
  Future<bool> deleteAll();
}
