import '../../models/tvshow_details.dart';

abstract class ISecondaryDatabaseService {
  Future<bool> saveTvshows(List<TvshowDetails> tvshows);
  Future<List<TvshowDetails>> getTvshows();
  Future<bool> deleteAll();
}
