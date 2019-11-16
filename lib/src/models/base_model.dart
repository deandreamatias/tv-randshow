import 'package:scoped_model/scoped_model.dart';

import 'package:tv_randshow/src/services/api_provider.dart';
import 'package:tv_randshow/src/services/secure_storage.dart';
import 'package:tv_randshow/src/utils/constants.dart';
import 'package:tv_randshow/src/utils/states.dart';

abstract class BaseModel extends Model {
  final SecureStorage secureStorage = SecureStorage();
  ViewState _state = ViewState.init;
  ViewState get state => _state;

  Future fetchData(String url, Map<String, dynamic> queryParameters) async {
    var uri = Uri.https(Url.apiUrl, url, queryParameters);
    final response = await ApiProvider().requestGet(uri.toString());

    return response.body;
  }

  setInit() {
    _setState(ViewState.init);
  }

  setLoading() {
    _setState(ViewState.loading);
  }

  setError() {
    _setState(ViewState.error);
  }

  _setState(ViewState viewState) {
    _state = viewState;
    print('# State of $runtimeType: $ViewState');
    notifyListeners();
  }
}
