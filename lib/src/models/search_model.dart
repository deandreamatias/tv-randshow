import 'package:tv_randshow/src/data/result.dart';
import 'package:tv_randshow/src/models/base_model.dart';
import 'package:tv_randshow/src/data/search.dart';
import 'package:tv_randshow/src/data/tvshow_details.dart';
import 'package:tv_randshow/src/services/database.dart';
import 'package:tv_randshow/src/ui/widgets/search_widget.dart';
import 'package:tv_randshow/src/utils/constants.dart';

class SearchModel extends BaseModel {
  final Database database = Database();
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
    final String apiKey = await secureStorage.readStorage(KeyStorate.API_KEY);
    final Map<String, String> queryParameters = <String, String>{
      'query': query,
      'page': page.toString(),
      'api_key': apiKey
    };

    final Search data =
        Search.fromRawJson(await fetchData(TVSHOW_SEARCH, queryParameters));
    if (page == 1) {
      setLoading();
      _listTvShow = data.results
          .map((Result result) => SearchWidget(result: result))
          .toList();
      setInit();
    } else {
      _listTvShow = data.results
          .map((Result result) => SearchWidget(result: result))
          .toList();
      setInit();
    }
    return _listTvShow;
  }

  Future<void> addToFav(int id) async {
    setLoading();
    final String apiKey = await secureStorage.readStorage(KeyStorate.API_KEY);
    final Map<String, String> queryParameters = <String, String>{
      'api_key': apiKey
    };

    final dynamic data =
        await fetchData(TVSHOW_DETAILS + id.toString(), queryParameters);
    database.insert(TvshowDetails.fromRawJson(data));
    setInit();
  }

  Future<void> deleteFav(int id) async {
    setLoading();
    final List<TvshowDetails> list = await database.queryList();
    final TvshowDetails item = list
        .firstWhere((TvshowDetails tvshowDetails) => tvshowDetails.id == id);
    database.delete(item.rowId).then((int _id) {
      _id != item.rowId ? setError() : setInit();
    }).catchError(
        (dynamic onError) => print('Error $onError to deleted row $id'));
  }

  Future<void> getDetails(int id) async {
    final String apiKey = await secureStorage.readStorage(KeyStorate.API_KEY);
    final Map<String, String> queryParameters = <String, String>{
      'api_key': apiKey
    };

    final dynamic data =
        await fetchData(TVSHOW_DETAILS + id.toString(), queryParameters);
    _tvshowDetails = TvshowDetails.fromRawJson(data);
  }
}
