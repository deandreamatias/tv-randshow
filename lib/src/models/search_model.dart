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

  List<SearchWidget> get listTvShow => _listTvShow;
  TvshowDetails get tvShowDetails => _tvshowDetails;

  Future<void> getSearch(String query) async {
    setLoading();
    final String apiKey = await secureStorage.readStorage(KeyStorate.API_KEY);
    final Map<String, String> queryParameters = <String, String>{'query': query, 'page': '1', 'api_key': apiKey};

    final dynamic data = await fetchData(TVSHOW_SEARCH, queryParameters);
    _listTvShow = Search.fromRawJson(data).results.map((Result result) {
      return SearchWidget(result: result);
    }).toList();
    setInit();
  }

  Future<void> addToFav(int id) async {
    setLoading();
    final String apiKey = await secureStorage.readStorage(KeyStorate.API_KEY);
    final Map<String, String> queryParameters = <String, String>{'api_key': apiKey};

    final dynamic data =
        await fetchData(TVSHOW_DETAILS + id.toString(), queryParameters);
    database.insert(TvshowDetails.fromRawJson(data));
    setInit();
  }

  Future<void> deleteFav(int id) async {
    setLoading();
    final List<TvshowDetails> list = await database.queryList();
    final TvshowDetails item = list.firstWhere((TvshowDetails tvshowDetails) => tvshowDetails.id == id);
    database.delete(item.rowId).then((int _id) {
      _id != item.rowId ? setError() : setInit();
    }).catchError((dynamic onError) => print('Error $onError to deleted row $id'));
  }

  Future<void> getDetails(int id) async {
    final String apiKey = await secureStorage.readStorage(KeyStorate.API_KEY);
    final Map<String, String> queryParameters = <String, String>{'api_key': apiKey};

    final dynamic data =
        await fetchData(TVSHOW_DETAILS + id.toString(), queryParameters);
    _tvshowDetails = TvshowDetails.fromRawJson(data);
  }
}
