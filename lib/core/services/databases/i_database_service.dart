import 'package:tv_randshow/core/tvshow/domain/models/tvshow_details.dart';

abstract class IDatabaseService {
  Future<void> saveTvshow(TvshowDetails tvshowDetails);
  Future<void> saveStreamings(TvshowDetails tvshowDetails);
  Future<List<TvshowDetails>> getTvshows();
  Future<bool> deleteTvshow(int id);
}
