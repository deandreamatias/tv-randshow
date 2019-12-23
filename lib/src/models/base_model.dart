import 'package:http/http.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:tv_randshow/src/services/api_provider.dart';
import 'package:tv_randshow/src/services/log_service.dart';
import 'package:tv_randshow/src/services/secure_storage.dart';
import 'package:tv_randshow/src/services/service_locator.dart';
import 'package:tv_randshow/src/utils/constants.dart';
import 'package:tv_randshow/src/utils/states.dart';

abstract class BaseModel extends Model {
  final LogService logger = locator<LogService>();
  final SecureStorage secureStorage = SecureStorage();
  ViewState _state = ViewState.init;
  ViewState get state => _state;

  Future<String> fetchData(
      String url, Map<String, dynamic> queryParameters) async {
    final Uri uri = Uri.https(apiUrl, url, queryParameters);
    final Response response = await ApiProvider()
        .requestGet(uri.toString())
        .catchError(
            (dynamic onError) => logger.printError('Get request', onError));

    return response?.body;
  }

  void setInit() {
    _setState(ViewState.init);
  }

  void setLoading() {
    _setState(ViewState.loading);
  }

  void setError() {
    _setState(ViewState.error);
  }

  void _setState(ViewState viewState) {
    _state = viewState;
    logger.printVerbose(_state.toString());
    notifyListeners();
  }
}
