// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../core/app/data/services/http_service.dart' as _i5;
import '../core/services/api_service.dart' as _i3;
import '../core/services/app_service.dart' as _i4;
import '../core/services/databases/hive_database_service.dart' as _i7;
import '../core/services/databases/i_database_service.dart' as _i6;
import '../core/services/databases/sql_database_service.dart' as _i8;
import '../core/services/favs_service.dart' as _i13;
import '../core/services/manage_files_service.dart' as _i11;
import '../core/services/random_service.dart' as _i12;
import '../core/streaming/data/repositories/streamings_repository.dart' as _i10;
import '../core/streaming/domain/interfaces/i_streamings_repository.dart'
    as _i9;
import '../core/streaming/domain/use_cases/get_tvshow_streamings_use_case.dart'
    as _i14;

const String _web = 'web';
const String _mobile = 'mobile';
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.ApiService>(() => _i3.ApiService());
  gh.lazySingleton<_i4.AppService>(() => _i4.AppService());
  gh.lazySingleton<_i5.HttpService>(() => _i5.HttpService());
  gh.lazySingleton<_i6.IDatabaseService>(() => _i7.HiveDatabaseService(),
      registerFor: {_web});
  gh.lazySingleton<_i6.IDatabaseService>(() => _i8.SqlDatabaseService(),
      registerFor: {_mobile});
  gh.factory<_i9.IStreamingsRepository>(
      () => _i10.StreamingsRepository(get<_i5.HttpService>()));
  gh.lazySingleton<_i11.ManageFilesService>(() => _i11.ManageFilesService(
      databaseService: get<_i6.IDatabaseService>(),
      appService: get<_i4.AppService>()));
  gh.lazySingleton<_i12.RandomService>(
      () => _i12.RandomService(apiService: get<_i3.ApiService>()));
  gh.lazySingleton<_i13.FavsService>(() => _i13.FavsService(
      apiService: get<_i3.ApiService>(),
      databaseService: get<_i6.IDatabaseService>()));
  gh.factory<_i14.GetTvshowStreamingsUseCase>(
      () => _i14.GetTvshowStreamingsUseCase(get<_i9.IStreamingsRepository>()));
  return get;
}
