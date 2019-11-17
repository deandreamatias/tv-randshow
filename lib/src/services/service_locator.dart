import 'package:get_it/get_it.dart';

import 'package:tv_randshow/src/models/app_model.dart';
import 'package:tv_randshow/src/models/home_model.dart';
import 'package:tv_randshow/src/models/loading_model.dart';
import 'package:tv_randshow/src/models/random_pick_model.dart';
import 'package:tv_randshow/src/models/search_model.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // Register services

  // Register models
  locator.registerFactory<AppModel>(() => AppModel());
  locator.registerFactory<SearchModel>(() => SearchModel());
  locator.registerFactory<HomeModel>(() => HomeModel());
  locator.registerFactory<LoadingModel>(() => LoadingModel());
  locator.registerFactory<RandomPickModel>(() => RandomPickModel());
}
