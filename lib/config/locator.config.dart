// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:tv_randshow/core/app/data/services/http_service.dart' as _i5;
import 'package:tv_randshow/core/app/data/services/local_storage_service.dart'
    as _i12;
import 'package:tv_randshow/core/services/api_service.dart' as _i3;
import 'package:tv_randshow/core/services/app_service.dart' as _i4;
import 'package:tv_randshow/core/services/databases/hive_database_service.dart'
    as _i7;
import 'package:tv_randshow/core/services/databases/i_database_service.dart'
    as _i6;
import 'package:tv_randshow/core/services/databases/i_secondary_database_service.dart'
    as _i8;
import 'package:tv_randshow/core/services/databases/sql_database_service.dart'
    as _i9;
import 'package:tv_randshow/core/services/favs_service.dart' as _i19;
import 'package:tv_randshow/core/services/manage_files_service.dart' as _i13;
import 'package:tv_randshow/core/services/random_service.dart' as _i15;
import 'package:tv_randshow/core/streaming/data/repositories/streamings_repository.dart'
    as _i11;
import 'package:tv_randshow/core/streaming/domain/interfaces/i_streamings_repository.dart'
    as _i10;
import 'package:tv_randshow/core/streaming/domain/use_cases/get_tvshow_streamings_use_case.dart'
    as _i20;
import 'package:tv_randshow/core/tvshow/data/repositories/migration_repository.dart'
    as _i22;
import 'package:tv_randshow/core/tvshow/domain/interfaces/i_migration_repository.dart'
    as _i21;
import 'package:tv_randshow/core/tvshow/domain/use_cases/add_streamings_migration_use_case.dart'
    as _i18;
import 'package:tv_randshow/core/tvshow/domain/use_cases/get_migration_status_use_case.dart'
    as _i24;
import 'package:tv_randshow/core/tvshow/domain/use_cases/mobile_database_migration_use_case.dart'
    as _i14;
import 'package:tv_randshow/core/tvshow/domain/use_cases/save_migration_status_use_case.dart'
    as _i23;
import 'package:tv_randshow/core/tvshow/domain/use_cases/verify_database_use_case.dart'
    as _i16;
import 'package:tv_randshow/core/tvshow/domain/use_cases/verify_old_database_use_case.dart'
    as _i17;

const String _mobile = 'mobile';

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i3.ApiService>(() => _i3.ApiService());
    gh.lazySingleton<_i4.AppService>(() => _i4.AppService());
    gh.lazySingleton<_i5.HttpService>(() => _i5.HttpService());
    gh.lazySingleton<_i6.IDatabaseService>(() => _i7.HiveDatabaseService());
    gh.lazySingleton<_i8.ISecondaryDatabaseService>(
      () => _i9.SqlDatabaseService(),
      registerFor: {_mobile},
    );
    gh.factory<_i10.IStreamingsRepository>(
        () => _i11.StreamingsRepository(gh<_i5.HttpService>()));
    gh.lazySingleton<_i12.LocalStorageService>(
        () => _i12.LocalStorageService());
    gh.lazySingleton<_i13.ManageFilesService>(() => _i13.ManageFilesService(
          databaseService: gh<_i6.IDatabaseService>(),
          appService: gh<_i4.AppService>(),
        ));
    gh.factory<_i14.MobileDatabaseMigrationUseCase>(
      () => _i14.MobileDatabaseMigrationUseCase(
        gh<_i6.IDatabaseService>(),
        gh<_i8.ISecondaryDatabaseService>(),
      ),
      registerFor: {_mobile},
    );
    gh.lazySingleton<_i15.RandomService>(
        () => _i15.RandomService(apiService: gh<_i3.ApiService>()));
    gh.factory<_i16.VerifyDatabaseUseCase>(
        () => _i16.VerifyDatabaseUseCase(gh<_i6.IDatabaseService>()));
    gh.factory<_i17.VerifyOldDatabaseUseCase>(
      () => _i17.VerifyOldDatabaseUseCase(gh<_i8.ISecondaryDatabaseService>()),
      registerFor: {_mobile},
    );
    gh.factory<_i18.AddStreamingsMigrationUseCase>(
        () => _i18.AddStreamingsMigrationUseCase(
              gh<_i6.IDatabaseService>(),
              gh<_i10.IStreamingsRepository>(),
            ));
    gh.lazySingleton<_i19.FavsService>(() => _i19.FavsService(
          apiService: gh<_i3.ApiService>(),
          databaseService: gh<_i6.IDatabaseService>(),
        ));
    gh.factory<_i20.GetTvshowStreamingsUseCase>(() =>
        _i20.GetTvshowStreamingsUseCase(gh<_i10.IStreamingsRepository>()));
    gh.factory<_i21.IMigrationRepository>(
        () => _i22.MigrationRepository(gh<_i12.LocalStorageService>()));
    gh.factory<_i23.SaveMigrationStatusUseCase>(
        () => _i23.SaveMigrationStatusUseCase(gh<_i21.IMigrationRepository>()));
    gh.factory<_i24.GetMigrationStatusUseCase>(
        () => _i24.GetMigrationStatusUseCase(gh<_i21.IMigrationRepository>()));
    return this;
  }
}
