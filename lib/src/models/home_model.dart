import 'package:flutter/material.dart';

import 'package:tv_randshow/src/models/base_model.dart';
import 'package:tv_randshow/src/services/database.dart';
import 'package:tv_randshow/src/ui/widgets/tvshow_fav_widget.dart';

class HomeModel extends BaseModel {
  final Database database = Database();
  List<TvshowFavWidget> _listTvShow;
  int rowId = 0;
  ValueNotifier<bool> _tvShowDetails = ValueNotifier<bool>(false);

  List<TvshowFavWidget> get listTvShow => _listTvShow;
  ValueNotifier<bool> get tvShowDetails => _tvShowDetails;

  getFavs() async {
    setLoading();
    database.queryList().then((list) {
      _listTvShow = list.map((tvshow) {
        print('Query List: ${tvshow.id}');
        return TvshowFavWidget(tvshowDetails: tvshow, rowId: rowId);
      }).toList();
      rowId++;
      setInit();
    }).catchError((onError) => print('Error get favs $onError'));
  }

  deleteFav(int id) {
    setLoading();
    database.delete(id);
    setInit();
  }

  getDetails(int id) async {}

  toggleDetails() {
    _tvShowDetails.value = !_tvShowDetails.value;
  }
}
