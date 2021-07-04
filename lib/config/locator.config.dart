// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../core/services/api_service.dart' as _i3;
import '../core/services/app_service.dart' as _i4;
import '../core/services/database_service.dart' as _i5;
import '../core/services/favs_service.dart' as _i6;
import '../core/services/hive_database_service.dart' as _i7;
import '../core/services/manage_files_service.dart' as _i8;
import '../core/services/random_service.dart'
    as _i9; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String environment, _i2.EnvironmentFilter environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.ApiService>(() => _i3.ApiService());
  gh.lazySingleton<_i4.AppService>(() => _i4.AppService());
  gh.lazySingleton<_i5.DatabaseService>(() => _i5.DatabaseService());
  gh.lazySingleton<_i6.FavsService>(() => _i6.FavsService(
      apiService: get<_i3.ApiService>(),
      databaseService: get<_i7.HiveDatabaseService>()));
  gh.lazySingleton<_i7.HiveDatabaseService>(() => _i7.HiveDatabaseService());
  gh.lazySingleton<_i8.ManageFilesService>(() => _i8.ManageFilesService(
      databaseService: get<_i7.HiveDatabaseService>(),
      appService: get<_i4.AppService>()));
  gh.lazySingleton<_i9.RandomService>(
      () => _i9.RandomService(apiService: get<_i3.ApiService>()));
  return get;
}
