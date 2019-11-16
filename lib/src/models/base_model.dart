import 'package:scoped_model/scoped_model.dart';

import 'package:tv_randshow/src/services/api_provider.dart';
import 'package:tv_randshow/src/services/secure_storage.dart';
import 'package:tv_randshow/src/utils/constants.dart';

enum BaseState { init, loading, error }

abstract class BaseModel extends Model {
  final SecureStorage secureStorage = SecureStorage();
  BaseState _state = BaseState.init;
  BaseState get state => _state;

  Future fetchData(String url, Map<String, dynamic> queryParameters) async {
    var uri = Uri.https(Url.apiUrl, url, queryParameters);
    final response = await ApiProvider().requestGet(uri.toString());

    return response.body;
  }

  setInit() {
    _setState(BaseState.init);
  }

  setLoading() {
    _setState(BaseState.loading);
  }

  setError() {
    _setState(BaseState.error);
  }

  _setState(BaseState baseState) {
    _state = baseState;
    print('# State of $runtimeType: $baseState');
    notifyListeners();
  }
}
