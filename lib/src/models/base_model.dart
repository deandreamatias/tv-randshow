import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:http/http.dart';
import 'package:scoped_model/scoped_model.dart';

import '../services/api_service.dart';
import '../services/database_service.dart';
import '../services/log_service.dart';
import '../services/secure_storage_service.dart';
import '../services/service_locator.dart';
import '../utils/constants.dart';
import '../utils/states.dart';

abstract class BaseModel extends Model {
  final Database database = Database();
  final LogService logger = locator<LogService>();
  final SecureStorage secureStorage = SecureStorage();
  ViewState _state = ViewState.init;
  bool hasConnection;
  ViewState get state => _state;

  Future<String> fetchData(
      String url, Map<String, dynamic> queryParameters) async {
    final Uri uri = Uri.https(apiUrl, url, queryParameters);
    final Response response = await ApiProvider()
        .requestGet(uri.toString())
        .catchError(
            (dynamic onError) => logger.printError('Get request', onError));
    if (response.statusCode == 200) {
      return response?.body;
    } else {
      logger.printError(
          'Error to fetch data: ${response.reasonPhrase}', response.statusCode);
      setError();
      return null;
    }
  }

  Future<void> checkConnection() async {
    hasConnection = await DataConnectionChecker().hasConnection;
    if (!hasConnection)
      logger.printError(
          'No connection', DataConnectionChecker().lastTryResults);
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
