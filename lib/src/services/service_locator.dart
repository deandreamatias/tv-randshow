import 'package:get_it/get_it.dart';

import 'package:tv_randshow/src/models/app_model.dart';
import 'package:tv_randshow/src/models/fav_model.dart';
import 'package:tv_randshow/src/models/loading_model.dart';
import 'package:tv_randshow/src/models/search_model.dart';
import 'package:tv_randshow/src/services/log_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // Register services
  locator.registerSingleton<LogService>(LogService.instance);

  // Register models
  locator.registerFactory<AppModel>(() => AppModel());
  locator.registerFactory<SearchModel>(() => SearchModel());
  locator.registerFactory<FavModel>(() => FavModel());
  locator.registerFactory<LoadingModel>(() => LoadingModel());
}
