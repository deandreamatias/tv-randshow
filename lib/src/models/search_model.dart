import 'package:flutter/material.dart';

import 'package:tv_randshow/src/models/base_model.dart';
// import 'package:tv_randshow/src/models/tvshow_search.dart';
// import 'package:tv_randshow/src/models/tvshow_details.dart';
import 'package:tv_randshow/src/services/database.dart';
import 'package:tv_randshow/src/ui/widgets/tvshow_search_widget.dart';
import 'package:tv_randshow/src/utils/constants.dart';

class SearchModel extends BaseModel {
  final Database database = Database();
  List<TvshowSearchWidget> _listTvShow;
  ValueNotifier<bool> _tvShowDetails = ValueNotifier<bool>(false);

  List<TvshowSearchWidget> get listTvShow => _listTvShow;
  ValueNotifier<bool> get tvShowDetails => _tvShowDetails;

  setInit();

  getSearch(String query) async {
    setLoading();
    final apiKey = await secureStorage.readStorage(KeyStorate.API_KEY);
    var queryParameters = {'query': query, 'page': '1', 'api_key': apiKey};

    var data = await fetchData(Url.TVSHOW_SEARCH, queryParameters);
    _listTvShow = TvshowSearch.fromRawJson(data).results.map((result) {
      return TvshowSearchWidget(
          tvshowName: result.name, urlImage: result.posterPath, tvshowId: result.id);
    }).toList();
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
