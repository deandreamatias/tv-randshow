import 'package:flutter/material.dart';

import 'package:tv_randshow/src/models/base_model.dart';
import 'package:tv_randshow/src/services/database.dart';
import 'package:tv_randshow/src/ui/widgets/fav_widget.dart';

class FavModel extends BaseModel {
  final Database database = Database();
  List<FavWidget> _listTvShow;
  ValueNotifier<bool> _tvShowDetails = ValueNotifier<bool>(false);

  List<FavWidget> get listTvShow => _listTvShow;
  ValueNotifier<bool> get tvShowDetails => _tvShowDetails;

  getFavs() async {
    setLoading();
    database.queryList().then((list) {
      _listTvShow = list.map((tvshow) {
        return FavWidget(tvshowDetails: tvshow);
      }).toList();
      setInit();
    }).catchError((onError) => print('Error get favs $onError'));
  }

  deleteFav(int id) {
    setLoading();
    database.delete(id).then((_id) {
      _id != id ? setError() : setInit();
    }).catchError((onError) => print('Error $onError to deleted row $id'));
  }

  getDetails(int index) async {
    _listTvShow.elementAt(index);
  }

  toggleDetails() {
    _tvShowDetails.value = !_tvShowDetails.value;
  }
}
