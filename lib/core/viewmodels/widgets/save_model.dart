import 'package:flutter/widgets.dart';

import '../../models/query.dart';
import '../../models/tvshow_details.dart';
import '../../services/api_service.dart';
import '../../services/database_service.dart';
import '../../services/secure_storage_service.dart';
import '../../utils/constants.dart';
import '../base_model.dart';

class SaveModel extends BaseModel {
  SaveModel({
    @required ApiService apiService,
    @required DatabaseService databaseService,
    @required SecureStorageService secureStorageService,
  })  : _apiService = apiService,
        _databaseService = databaseService,
        _secureStorageService = secureStorageService;
  final ApiService _apiService;
  final DatabaseService _databaseService;
  final SecureStorageService _secureStorageService;

  TvshowDetails item;

  // Future<void> getDatabaseInfo(int id) async {
  //   final List<TvshowDetails> list = await _databaseService.queryList();
  //   item = list
  //       .firstWhere((TvshowDetails tvshowDetails) => tvshowDetails.id == id);

  //   _databaseService.delete(item.rowId).then((int _id) {
  //     _id != item.rowId ? setError() : setBusy(false);
  //   }).catchError(
  //       (dynamic onError) => logger.printError('Delete row $id', onError));
  // }

  Future<bool> addFav(int id, String language) async {
    setBusy(true);
    final Query query = Query(
      apiKey: await _secureStorageService.readStorage(KeyStore.API_KEY),
      language: language,
    );
    final TvshowDetails tvshowDetails =
        await _apiService.getDetailsTv(query, id);
    if (tvshowDetails != null) {
      setBusy(false);
      _databaseService.insert(tvshowDetails);
      return true;
    } else {
      setBusy(false);
      return false;
    }
  }

  // Future<void> deleteFav(int id) async {
  //   setBusy(true);
  //   final List<TvshowDetails> list = await _databaseService.queryList();
  //   final TvshowDetails item = list
  //       .firstWhere((TvshowDetails tvshowDetails) => tvshowDetails.id == id);
  //   _databaseService.delete(item.rowId).then((int _id) {
  //     _id != item.rowId ? setError() : setBusy(false);
  //   }).catchError(
  //       (dynamic onError) => logger.printError('Delete row $id', onError));
  // }
}
