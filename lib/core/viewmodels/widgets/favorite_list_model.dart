import 'package:flutter/widgets.dart';

import '../../models/tvshow_details.dart';
import '../../services/database_service.dart';
import '../base_model.dart';

class FavoriteListModel extends BaseModel {
  FavoriteListModel({
    @required DatabaseService databaseService,
  }) : _databaseService = databaseService;
  final DatabaseService _databaseService;

  Future<List<TvshowDetails>> loadFavs() async {
    final List<TvshowDetails> list = await _databaseService.queryList();
    return list;
  }
}
