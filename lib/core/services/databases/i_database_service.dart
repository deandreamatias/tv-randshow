import '../../models/tvshow_details.dart';
import '../../streaming/domain/models/streaming.dart';

abstract class IDatabaseService {
  Future<bool> saveTvshow(TvshowDetails tvshowDetails);
  Future<bool> saveStreamings(List<StreamingDetail> streamings, int tvshowId);
  Future<List<TvshowDetails>> getTvshows();
  Future<bool> deleteTvshow(int id);
}
