import '../../models/tvshow_details.dart';

abstract class IDatabaseService {
  Future<bool> saveTvshow(TvshowDetails tvshowDetails);
  Future<List<TvshowDetails>> getTvshows();
  Future<bool> deleteTvshow(int id);
}
