import 'package:flutter/widgets.dart';

import 'package:tv_randshow/core/models/tvshow_details.dart';
import 'package:tv_randshow/core/services/database_service.dart';
import 'package:tv_randshow/core/services/log_service.dart';
import '../base_model.dart';

class FavoriteListModel extends BaseModel {
  FavoriteListModel({
    @required DatabaseService databaseService,
  }) : _databaseService = databaseService;
  final DatabaseService _databaseService;

  final LogService _logger = LogService.instance;
  List<FavWidget> _listTvShow;
  TvshowDetails _tvshowDetails;

  List<FavWidget> get listTvShow => _listTvShow;
  TvshowDetails get tvshowDetails => _tvshowDetails;

  Future<void> getFavs() async {
    setBusy(true);
    _databaseService.queryList().then((List<TvshowDetails> list) {
      _listTvShow = list.map((TvshowDetails tvshow) {
        return FavWidget(tvshowDetails: tvshow);
      }).toList();
      setBusy(false);
    }).catchError((dynamic onError) => _logger.logger.i('Get favs', onError));
  }
}
