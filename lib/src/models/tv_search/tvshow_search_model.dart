import 'package:tv_randshow/src/models/base_model.dart';
import 'package:tv_randshow/src/models/tv_search/tvshow_search.dart';
import 'package:tv_randshow/src/ui/widgets/tvshow_widget.dart';
import 'package:tv_randshow/src/utils/constants.dart';

class TvshowSearchModel extends BaseModel {
  List<TvshowWidget> listTvShow;

  Future<List<TvshowWidget>> getSearch(String query) async {
    setLoading();
    final apiKey = await secureStorage.readStorage(KeyStorate.API_KEY);
    var queryParameters = {'api_key': apiKey, 'language': 'en-US', 'page': '1', 'query': query};

    var data = await fetchData(Url.TVSHOW_SEARCH, queryParameters);
    List<TvshowWidget> listTvShow = TvshowSearch.fromRawJson(data).results.map((result) {
      return TvshowWidget(tvshowName: result.name, urlImage: result.posterPath);
    }).toList();

    return listTvShow;
  }
}
