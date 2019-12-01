import 'package:flutter/material.dart';

import 'package:tv_randshow/src/models/base_model.dart';
import 'package:tv_randshow/src/services/database.dart';
import 'package:tv_randshow/src/ui/widgets/tvshow_fav_widget.dart';

class HomeModel extends BaseModel {
  final Database database = Database();
  List<TvshowFavWidget> _listTvShow;
  ValueNotifier<bool> _tvShowDetails = ValueNotifier<bool>(false);

  List<TvshowFavWidget> get listTvShow => _listTvShow;
  ValueNotifier<bool> get tvShowDetails => _tvShowDetails;

  getFavs() async {
    setLoading();
    database.queryList().then((list) {
      _listTvShow = list.map((tvshow) {
        return TvshowFavWidget(tvshowDetails: tvshow);
      }).toList();
      setInit();
    }).catchError((onError) => print('Error get favs $onError'));
  }

  deleteFav(int id) {
    setLoading();
    database.delete(id);
    setInit();
  }

  getDetails(int index) async {
    _listTvShow.elementAt(index);
  }

  toggleDetails() {
    _tvShowDetails.value = !_tvShowDetails.value;
  }
}
