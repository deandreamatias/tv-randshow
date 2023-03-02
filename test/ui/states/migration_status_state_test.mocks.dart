// Mocks generated by Mockito 5.1.0 from annotations
// in tv_randshow/test/ui/states/migration_status_state_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:tv_randshow/core/tvshow/domain/models/migration_status.dart'
    as _i5;
import 'package:tv_randshow/core/tvshow/domain/use_cases/get_migration_status_use_case.dart'
    as _i4;
import 'package:tv_randshow/core/tvshow/domain/use_cases/save_migration_status_use_case.dart'
    as _i6;
import 'package:tv_randshow/core/tvshow/domain/use_cases/verify_database_use_case.dart'
    as _i2;
import 'package:tv_randshow/core/tvshow/domain/use_cases/verify_old_database_use_case.dart'
    as _i7;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

/// A class which mocks [VerifyDatabaseUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockVerifyDatabaseUseCase extends _i1.Mock
    implements _i2.VerifyDatabaseUseCase {
  MockVerifyDatabaseUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<bool> call() => (super.noSuchMethod(Invocation.method(#call, []),
      returnValue: Future<bool>.value(false)) as _i3.Future<bool>);
}

/// A class which mocks [GetMigrationStatusUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetMigrationStatusUseCase extends _i1.Mock
    implements _i4.GetMigrationStatusUseCase {
  MockGetMigrationStatusUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<_i5.MigrationStatus> call() =>
      (super.noSuchMethod(Invocation.method(#call, []),
              returnValue:
                  Future<_i5.MigrationStatus>.value(_i5.MigrationStatus.init))
          as _i3.Future<_i5.MigrationStatus>);
}

/// A class which mocks [SaveMigrationStatusUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockSaveMigrationStatusUseCase extends _i1.Mock
    implements _i6.SaveMigrationStatusUseCase {
  MockSaveMigrationStatusUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<bool> call(_i5.MigrationStatus? status) =>
      (super.noSuchMethod(Invocation.method(#call, [status]),
          returnValue: Future<bool>.value(false)) as _i3.Future<bool>);
}

/// A class which mocks [VerifyOldDatabaseUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockVerifyOldDatabaseUseCase extends _i1.Mock
    implements _i7.VerifyOldDatabaseUseCase {
  MockVerifyOldDatabaseUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<bool> call() => (super.noSuchMethod(Invocation.method(#call, []),
      returnValue: Future<bool>.value(false)) as _i3.Future<bool>);
}