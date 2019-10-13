import 'package:tv_randshow/src/models/base_model.dart';
import 'package:tv_randshow/src/models/tv_search/tvshow_search.dart';
import 'package:tv_randshow/src/ui/widgets/tvshow_search_widget.dart';
import 'package:tv_randshow/src/utils/constants.dart';

class TvshowSearchModel extends BaseModel {
  List<TvshowSearchWidget> _listTvShow;

  List<TvshowSearchWidget> get listTvShow => _listTvShow;
  setInit();

  getSearch(String query) async {
    setLoading();
    final apiKey = await secureStorage.readStorage(KeyStorate.API_KEY);
    var queryParameters = {'query': query, 'page': '1', 'api_key': apiKey};

    var data = await fetchData(Url.TVSHOW_SEARCH, queryParameters);
    _listTvShow = TvshowSearch.fromRawJson(data).results.map((result) {
      return TvshowSearchWidget(tvshowName: result.name, urlImage: result.posterPath);
    }).toList();
    setInit();
  }
}
