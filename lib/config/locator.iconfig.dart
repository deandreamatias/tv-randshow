// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:tv_randshow/core/services/api_service.dart';
import 'package:tv_randshow/core/services/database_service.dart';
import 'package:tv_randshow/core/services/favs_service.dart';
import 'package:tv_randshow/core/services/random_service.dart';
import 'package:get_it/get_it.dart';
import 'package:tv_randshow/core/viewmodels/widgets/favorite_list_model.dart';

void $initGetIt(GetIt g, {String environment}) {
  g.registerLazySingleton<ApiService>(() => ApiService());
  g.registerLazySingleton<DatabaseService>(() => DatabaseService());
  g.registerLazySingleton<FavsService>(() => FavsService(
      apiService: g<ApiService>(), databaseService: g<DatabaseService>()));
  g.registerLazySingleton<RandomService>(
      () => RandomService(apiService: g<ApiService>()));
}
