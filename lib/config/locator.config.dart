// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../core/services/api_service.dart';
import '../core/services/app_service.dart';
import '../core/services/database_service.dart';
import '../core/services/favs_service.dart';
import '../core/services/random_service.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<ApiService>(() => ApiService());
  gh.lazySingleton<AppService>(() => AppService());
  gh.lazySingleton<DatabaseService>(() => DatabaseService());
  gh.lazySingleton<FavsService>(() => FavsService(
      apiService: get<ApiService>(), databaseService: get<DatabaseService>()));
  gh.lazySingleton<RandomService>(
      () => RandomService(apiService: get<ApiService>()));
  return get;
}
