// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../core/app/data/services/http_service.dart' as _i5;
import '../core/app/data/services/local_storage_service.dart' as _i12;
import '../core/services/api_service.dart' as _i3;
import '../core/services/app_service.dart' as _i4;
import '../core/services/databases/hive_database_service.dart' as _i7;
import '../core/services/databases/i_database_service.dart' as _i6;
import '../core/services/databases/i_secondary_database_service.dart' as _i8;
import '../core/services/databases/sql_database_service.dart' as _i9;
import '../core/services/favs_service.dart' as _i17;
import '../core/services/manage_files_service.dart' as _i13;
import '../core/services/random_service.dart' as _i15;
import '../core/streaming/data/repositories/streamings_repository.dart' as _i11;
import '../core/streaming/domain/interfaces/i_streamings_repository.dart'
    as _i10;
import '../core/streaming/domain/use_cases/get_tvshow_streamings_use_case.dart'
    as _i18;
import '../core/tvshow/data/repositories/migration_repository.dart' as _i20;
import '../core/tvshow/domain/interfaces/i_migration_repository.dart' as _i19;
import '../core/tvshow/domain/use_cases/add_streamings_migration_use_case.dart'
    as _i22;
import '../core/tvshow/domain/use_cases/get_migration_status_use_case.dart'
    as _i23;
import '../core/tvshow/domain/use_cases/mobile_database_migration_use_case.dart'
    as _i14;
import '../core/tvshow/domain/use_cases/save_migration_status_use_case.dart'
    as _i21;
import '../core/tvshow/domain/use_cases/verify_old_database_use_case.dart'
    as _i16;

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
  gh.lazySingleton<_i12.LocalStorageService>(() => _i12.LocalStorageService());
  gh.lazySingleton<_i13.ManageFilesService>(() => _i13.ManageFilesService(
      databaseService: get<_i6.IDatabaseService>(),
      appService: get<_i4.AppService>()));
  gh.factory<_i14.MobileDatabaseMigrationUseCase>(
      () => _i14.MobileDatabaseMigrationUseCase(
          get<_i6.IDatabaseService>(), get<_i8.ISecondaryDatabaseService>()),
      registerFor: {_mobile});
  gh.lazySingleton<_i15.RandomService>(
      () => _i15.RandomService(apiService: get<_i3.ApiService>()));
  gh.factory<_i16.VerifyOldDatabaseUseCase>(
      () => _i16.VerifyOldDatabaseUseCase(get<_i8.ISecondaryDatabaseService>()),
      registerFor: {_mobile});
  gh.lazySingleton<_i17.FavsService>(() => _i17.FavsService(
      apiService: get<_i3.ApiService>(),
      databaseService: get<_i6.IDatabaseService>()));
  gh.factory<_i18.GetTvshowStreamingsUseCase>(
      () => _i18.GetTvshowStreamingsUseCase(get<_i10.IStreamingsRepository>()));
  gh.factory<_i19.IMigrationRepository>(
      () => _i20.MigrationRepository(get<_i12.LocalStorageService>()));
  gh.factory<_i21.SaveMigrationStatusUseCase>(
      () => _i21.SaveMigrationStatusUseCase(get<_i19.IMigrationRepository>()));
  gh.factory<_i22.AddStreamingsMigrationUseCase>(() =>
      _i22.AddStreamingsMigrationUseCase(
          get<_i6.IDatabaseService>(), get<_i18.GetTvshowStreamingsUseCase>()));
  gh.factory<_i23.GetMigrationStatusUseCase>(
      () => _i23.GetMigrationStatusUseCase(get<_i19.IMigrationRepository>()));
  return get;
}
