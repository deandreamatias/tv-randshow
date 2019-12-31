import '../data/result.dart';
import '../data/search.dart';
import '../data/tvshow_details.dart';
import '../ui/widgets/search_widget.dart';
import '../utils/constants.dart';
import 'base_model.dart';

class SearchModel extends BaseModel {
  List<SearchWidget> _listTvShow;
  TvshowDetails _tvshowDetails;
  bool searched = false;

  List<SearchWidget> get listTvShow => _listTvShow;
  TvshowDetails get tvShowDetails => _tvshowDetails;

  void getSearch() {
    setLoading();
    searched = true;
    setInit();
  }

  void onSearch() {
    setLoading();
    searched = false;
    setInit();
  }

  Future<List<SearchWidget>> loadList(String query, int page) async {
    final String apiKey = await secureStorage.readStorage(KeyStore.API_KEY);
    final Map<String, String> queryParameters = <String, String>{
      'query': query,
      'page': page.toString(),
      'api_key': apiKey
    };

    final dynamic data = await fetchData(TVSHOW_SEARCH, queryParameters);

    if (data != null && data.isNotEmpty) {
      final Search search = Search.fromRawJson(data);
      if (page == 1) {
        setLoading();
        _listTvShow = search.results
            .map((Result result) => SearchWidget(result: result))
            .toList();
        setInit();
      } else {
        _listTvShow = search.results
            .map((Result result) => SearchWidget(result: result))
            .toList();
        setInit();
      }
      return _listTvShow;
    } else {
      setError();
      return null;
    }
  }

  Future<void> addToFav(int id) async {
    setLoading();
    final String apiKey = await secureStorage.readStorage(KeyStore.API_KEY);
    final Map<String, String> queryParameters = <String, String>{
      'api_key': apiKey
    };

    final dynamic data =
        await fetchData(TVSHOW_DETAILS + id.toString(), queryParameters);
    if (data != null && data.isNotEmpty) {
      database.insert(TvshowDetails.fromRawJson(data));
      setInit();
    } else {
      setError();
    }
  }

  Future<void> deleteFav(int id) async {
    setLoading();
    final List<TvshowDetails> list = await database.queryList();
    final TvshowDetails item = list
        .firstWhere((TvshowDetails tvshowDetails) => tvshowDetails.id == id);
    database.delete(item.rowId).then((int _id) {
      _id != item.rowId ? setError() : setInit();
    }).catchError(
        (dynamic onError) => logger.printError('Delete row $id', onError));
  }

  Future<void> getDetails(int id) async {
    final String apiKey = await secureStorage.readStorage(KeyStore.API_KEY);
    final Map<String, String> queryParameters = <String, String>{
      'api_key': apiKey
    };

    final dynamic data =
        await fetchData(TVSHOW_DETAILS + id.toString(), queryParameters);
    if (data != null && data.isNotEmpty) {
      _tvshowDetails = TvshowDetails.fromRawJson(data);
    }
  }
}
