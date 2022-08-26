import '../../models/tvshow_details.dart';

abstract class ISecondaryDatabaseService {
  Future<List<TvshowDetails>> getTvshows();
  Future<bool> deleteAll();
}
