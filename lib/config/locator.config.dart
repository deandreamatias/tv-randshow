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
import '../core/services/databases/i_secondary_database_service.dart' as _i8;
import '../core/services/databases/sql_database_service.dart' as _i9;
import '../core/services/favs_service.dart' as _i16;
import '../core/services/manage_files_service.dart' as _i12;
import '../core/services/random_service.dart' as _i14;
import '../core/streaming/data/repositories/streamings_repository.dart' as _i11;
import '../core/streaming/domain/interfaces/i_streamings_repository.dart'
    as _i10;
import '../core/streaming/domain/use_cases/get_tvshow_streamings_use_case.dart'
    as _i17;
import '../core/tvshow/domain/use_cases/add_streamings_migration_use_case.dart'
    as _i15;
import '../core/tvshow/domain/use_cases/mobile_database_migration_use_case.dart'
    as _i13;

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
  gh.lazySingleton<_i6.IDatabaseService>(() => _i7.HiveDatabaseService());
  gh.lazySingleton<_i8.ISecondaryDatabaseService>(
      () => _i9.SqlDatabaseService(),
      registerFor: {_mobile});
  gh.factory<_i10.IStreamingsRepository>(
      () => _i11.StreamingsRepository(get<_i5.HttpService>()));
  gh.lazySingleton<_i12.ManageFilesService>(() => _i12.ManageFilesService(
      databaseService: get<_i6.IDatabaseService>(),
      appService: get<_i4.AppService>()));
  gh.factory<_i13.MobileDatabaseMigrationUseCase>(
      () => _i13.MobileDatabaseMigrationUseCase(
          get<_i6.IDatabaseService>(), get<_i8.ISecondaryDatabaseService>()),
      registerFor: {_mobile});
  gh.lazySingleton<_i14.RandomService>(
      () => _i14.RandomService(apiService: get<_i3.ApiService>()));
  gh.factory<_i15.AddStreamingsMigrationUseCase>(
      () => _i15.AddStreamingsMigrationUseCase(get<_i6.IDatabaseService>()));
  gh.lazySingleton<_i16.FavsService>(() => _i16.FavsService(
      apiService: get<_i3.ApiService>(),
      databaseService: get<_i6.IDatabaseService>()));
  gh.factory<_i17.GetTvshowStreamingsUseCase>(
      () => _i17.GetTvshowStreamingsUseCase(get<_i10.IStreamingsRepository>()));
  return get;
}
