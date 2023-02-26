import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_randshow/core/tvshow/domain/models/migration_status.dart';
import 'package:tv_randshow/core/tvshow/domain/use_cases/get_migration_status_use_case.dart';
import 'package:tv_randshow/core/tvshow/domain/use_cases/save_migration_status_use_case.dart';
import 'package:tv_randshow/core/tvshow/domain/use_cases/verify_database_use_case.dart';
import 'package:tv_randshow/core/tvshow/domain/use_cases/verify_old_database_use_case.dart';
import 'package:tv_randshow/ui/states/migration_status_state.dart';

import 'migration_status_state_test.mocks.dart';

@GenerateMocks([
  VerifyDatabaseUseCase,
  GetMigrationStatusUseCase,
  SaveMigrationStatusUseCase,
  VerifyOldDatabaseUseCase,
])
void main() {
  final _faker = Faker();
  final _verifyDatabaseUseCase = MockVerifyDatabaseUseCase();
  final _getMigrationStatusUseCase = MockGetMigrationStatusUseCase();
  final _saveMigrationStatusUseCase = MockSaveMigrationStatusUseCase();
  final _verifyOldDatabaseUseCase = MockVerifyOldDatabaseUseCase();
  late MigrationStatusState webState;
  late MigrationStatusState mobileState;

  MigrationStatus getRandomStatus(
      {List<MigrationStatus> excludedStatus = const []}) {
    return _faker.randomGenerator.element(MigrationStatus.values
        .where((element) => !excludedStatus.contains(element))
        .toList());
  }

  setUp(() {
    reset(_verifyDatabaseUseCase);
    reset(_getMigrationStatusUseCase);
    reset(_saveMigrationStatusUseCase);
    webState = MigrationStatusState(
      isWeb: true,
      getMigrationStatusUseCase: _getMigrationStatusUseCase,
      saveMigrationStatusUseCase: _saveMigrationStatusUseCase,
      verifyDatabaseUseCase: _verifyDatabaseUseCase,
    );
    mobileState = MigrationStatusState(
      isWeb: false,
      getMigrationStatusUseCase: _getMigrationStatusUseCase,
      saveMigrationStatusUseCase: _saveMigrationStatusUseCase,
      verifyDatabaseUseCase: _verifyDatabaseUseCase,
      verifyOldDatabaseUseCase: _verifyOldDatabaseUseCase,
    );
  });
  group('is web', () {
    group('loadStatus', () {
      test('when migration status is complete then return immediately',
          () async {
        when(_getMigrationStatusUseCase())
            .thenAnswer((_) async => MigrationStatus.complete);

        await webState.loadStatus();

        expect(webState.completeMigration, isTrue);

        when(_getMigrationStatusUseCase())
            .thenAnswer((_) async => MigrationStatus.empty);

        await webState.loadStatus();

        verify(_getMigrationStatusUseCase()).called(2);
        expect(webState.completeMigration, isTrue);
      });
      test(
          'when migration status is not complete or empty then complete migration is false',
          () async {
        when(_getMigrationStatusUseCase()).thenAnswer(
          (_) async => getRandomStatus(excludedStatus: [
            MigrationStatus.complete,
            MigrationStatus.empty
          ]),
        );
        when(_verifyDatabaseUseCase()).thenAnswer((_) async => false);

        await webState.loadStatus();

        verify(_getMigrationStatusUseCase()).called(1);
        verify(_verifyDatabaseUseCase()).called(1);
        expect(webState.completeMigration, isFalse);
      });
      test(
          'when migration status empty on verification database then complete migration is true',
          () async {
        when(_getMigrationStatusUseCase()).thenAnswer(
          (_) async => getRandomStatus(excludedStatus: [
            MigrationStatus.complete,
            MigrationStatus.empty
          ]),
        );
        when(_verifyDatabaseUseCase()).thenAnswer((_) async => true);

        await webState.loadStatus();

        verify(_getMigrationStatusUseCase()).called(1);
        verify(_verifyDatabaseUseCase()).called(1);
        expect(webState.completeMigration, isTrue);
      });
    });
    group('saveStatus', () {
      test('when status is different that init then save it', () async {
        final MigrationStatus status =
            getRandomStatus(excludedStatus: [MigrationStatus.init]);
        when(_saveMigrationStatusUseCase(status)).thenAnswer((_) async => true);

        await webState.saveStatus(status);

        verify(_saveMigrationStatusUseCase(status)).called(1);
        expect(webState.migration, status);
      });
      test('when status is init then do nothing', () async {
        final MigrationStatus _status = MigrationStatus.init;
        when(_saveMigrationStatusUseCase(_status))
            .thenAnswer((_) async => false);

        await webState.saveStatus(_status);

        verifyNever(_saveMigrationStatusUseCase(_status));
        expect(webState.migration, _status);
      });
    });
  });
  group('is mobile', () {
    group('loadStatus', () {
      test('when migration status is complete then return immediately',
          () async {
        when(_getMigrationStatusUseCase())
            .thenAnswer((_) async => MigrationStatus.complete);

        await mobileState.loadStatus();

        expect(mobileState.completeMigration, isTrue);

        when(_getMigrationStatusUseCase())
            .thenAnswer((_) async => MigrationStatus.empty);

        await mobileState.loadStatus();

        verify(_getMigrationStatusUseCase()).called(2);
        expect(mobileState.completeMigration, isTrue);
      });
      test(
          'when migration status is not complete or empty then complete migration is false',
          () async {
        when(_getMigrationStatusUseCase()).thenAnswer(
          (_) async => getRandomStatus(excludedStatus: [
            MigrationStatus.complete,
            MigrationStatus.empty
          ]),
        );
        when(_verifyDatabaseUseCase()).thenAnswer((_) async => false);
        when(_saveMigrationStatusUseCase(MigrationStatus.completeDatabase))
            .thenAnswer((_) async => true);

        await mobileState.loadStatus();

        verify(_getMigrationStatusUseCase()).called(1);
        verify(_verifyDatabaseUseCase()).called(1);
        verify(_saveMigrationStatusUseCase(MigrationStatus.completeDatabase))
            .called(1);
        expect(mobileState.completeMigration, isFalse);
      });
      group('verify old database', () {
        test('when old database is empty then migration status is empty',
            () async {
          when(_getMigrationStatusUseCase()).thenAnswer(
            (_) async => getRandomStatus(excludedStatus: [
              MigrationStatus.complete,
              MigrationStatus.empty
            ]),
          );
          when(_verifyDatabaseUseCase()).thenAnswer((_) async => true);
          when(_verifyOldDatabaseUseCase()).thenAnswer((_) async => true);
          when(_saveMigrationStatusUseCase(MigrationStatus.empty))
              .thenAnswer((_) async => true);

          await mobileState.loadStatus();

          verify(_getMigrationStatusUseCase()).called(1);
          verify(_verifyDatabaseUseCase()).called(1);
          verify(_verifyOldDatabaseUseCase()).called(1);
          verify(_saveMigrationStatusUseCase(MigrationStatus.empty)).called(1);
          verifyNever(
              _saveMigrationStatusUseCase(MigrationStatus.completeDatabase));
          expect(mobileState.migration, MigrationStatus.empty);
        });
        test('when old database is not empty then return immediately',
            () async {
          final status = getRandomStatus(excludedStatus: [
            MigrationStatus.complete,
            MigrationStatus.empty
          ]);
          when(_getMigrationStatusUseCase()).thenAnswer((_) async => status);
          when(_verifyDatabaseUseCase()).thenAnswer((_) async => true);
          when(_verifyOldDatabaseUseCase()).thenAnswer((_) async => false);
          when(_saveMigrationStatusUseCase(MigrationStatus.init))
              .thenAnswer((_) async => true);

          await mobileState.loadStatus();

          verify(_getMigrationStatusUseCase()).called(1);
          verify(_verifyDatabaseUseCase()).called(1);
          verify(_verifyOldDatabaseUseCase()).called(1);
          verifyNever(
              _saveMigrationStatusUseCase(MigrationStatus.completeDatabase));
          expect(mobileState.migration, status);
        });
      });
    });
    group('saveStatus', () {
      test('when status is different that init then save it', () async {
        final MigrationStatus status =
            getRandomStatus(excludedStatus: [MigrationStatus.init]);
        when(_saveMigrationStatusUseCase(status)).thenAnswer((_) async => true);

        await mobileState.saveStatus(status);

        verify(_saveMigrationStatusUseCase(status)).called(1);
        expect(mobileState.migration, status);
      });
      test('when status is init then do nothing', () async {
        final MigrationStatus _status = MigrationStatus.init;
        when(_saveMigrationStatusUseCase(_status))
            .thenAnswer((_) async => false);

        await mobileState.saveStatus(_status);

        verifyNever(_saveMigrationStatusUseCase(_status));
        expect(mobileState.migration, _status);
      });
    });
  });
}
