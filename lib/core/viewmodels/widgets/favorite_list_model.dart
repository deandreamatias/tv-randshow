import 'package:flutter/widgets.dart';

import '../../models/tvshow_details.dart';
import '../../services/database_service.dart';
import '../base_model.dart';

class FavoriteListModel extends BaseModel {
  FavoriteListModel({
    @required DatabaseService databaseService,
  }) : _databaseService = databaseService;
  final DatabaseService _databaseService;

  List<TvshowDetails> _listFavs;

  List<TvshowDetails> get listFavs => _listFavs;

  Future<void> loadFavs() async {
    setBusy(true);
    _listFavs = await _databaseService.queryList();
    setBusy(false);
  }

  void deleteFav(int rowId) {
    setBusy(true);
    _listFavs.removeWhere((TvshowDetails tvshow) => tvshow.rowId == rowId);
    setBusy(false);
  }
}
