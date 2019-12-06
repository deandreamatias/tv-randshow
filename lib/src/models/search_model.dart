import 'package:flutter/material.dart';

import 'package:tv_randshow/src/models/base_model.dart';
import 'package:tv_randshow/src/data/search.dart';
import 'package:tv_randshow/src/data/tvshow_details.dart';
import 'package:tv_randshow/src/services/database.dart';
import 'package:tv_randshow/src/ui/widgets/search_widget.dart';
import 'package:tv_randshow/src/utils/constants.dart';

class SearchModel extends BaseModel {
  final Database database = Database();
  List<SearchWidget> _listTvShow;
  ValueNotifier<bool> _tvShowDetails = ValueNotifier<bool>(false);

  List<SearchWidget> get listTvShow => _listTvShow;
  ValueNotifier<bool> get tvShowDetails => _tvShowDetails;

  getSearch(String query) async {
    setLoading();
    final apiKey = await secureStorage.readStorage(KeyStorate.API_KEY);
    var queryParameters = {'query': query, 'page': '1', 'api_key': apiKey};

    var data = await fetchData(Url.TVSHOW_SEARCH, queryParameters);
    _listTvShow = Search.fromRawJson(data).results.map((result) {
      return SearchWidget(result: result);
    }).toList();
    setInit();
  }

  addToFav(int id) async {
    setLoading();
    final apiKey = await secureStorage.readStorage(KeyStorate.API_KEY);
    var queryParameters = {'api_key': apiKey};

    var data =
        await fetchData(Url.TVSHOW_DETAILS + id.toString(), queryParameters);
    database.insert(TvshowDetails.fromRawJson(data));
    setInit();
  }

  deleteFav(int id) async {
    setLoading();
    final list = await database.queryList();
    final item = list.firstWhere((tvshowDetails) => tvshowDetails.id == id);
    database.delete(item.rowId).then((_id) {
      _id != item.rowId ? setError() : setInit();
    }).catchError((onError) => print('Error $onError to deleted row $id'));
  }

  toggleDetails() {
    _tvShowDetails.value = !_tvShowDetails.value;
  }
}
