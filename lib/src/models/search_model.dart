import 'package:flutter/material.dart';

import 'package:tv_randshow/src/models/base_model.dart';
import 'package:tv_randshow/src/data/search.dart';
import 'package:tv_randshow/src/data/tvshow_details.dart';
import 'package:tv_randshow/src/services/database.dart';
import 'package:tv_randshow/src/ui/widgets/tvshow_search_widget.dart';
import 'package:tv_randshow/src/utils/constants.dart';

class SearchModel extends BaseModel {
  final Database database = Database();
  List<TvshowSearchWidget> _listTvShow;
  ValueNotifier<bool> _tvShowDetails = ValueNotifier<bool>(false);
  int rowId = 0;

  List<TvshowSearchWidget> get listTvShow => _listTvShow;
  ValueNotifier<bool> get tvShowDetails => _tvShowDetails;

  getSearch(String query) async {
    setLoading();
    final apiKey = await secureStorage.readStorage(KeyStorate.API_KEY);
    var queryParameters = {'query': query, 'page': '1', 'api_key': apiKey};

    var data = await fetchData(Url.TVSHOW_SEARCH, queryParameters);
    _listTvShow = Search.fromRawJson(data).results.map((result) {
      return TvshowSearchWidget(result: result, rowId: rowId);
    }).toList();
    rowId++;
    setInit();
  }

  addToFav(int id) async {
    setLoading();
    final apiKey = await secureStorage.readStorage(KeyStorate.API_KEY);
    var queryParameters = {'api_key': apiKey};

    var data = await fetchData(Url.TVSHOW_DETAILS + id.toString(), queryParameters);
    database.insert(TvshowDetails.fromRawJson(data));
    database.query();
    setInit();
  }

  toggleDetails() {
    _tvShowDetails.value = !_tvShowDetails.value;
  }
}
