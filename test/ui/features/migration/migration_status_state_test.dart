// ignore_for_file: avoid-ignoring-return-values, no-magic-number
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_randshow/core/migration/domain/models/migration_status.dart';
import 'package:tv_randshow/core/migration/domain/use_cases/get_migration_status_use_case.dart';
import 'package:tv_randshow/core/migration/domain/use_cases/save_migration_status_use_case.dart';
import 'package:tv_randshow/core/migration/domain/use_cases/verify_database_use_case.dart';
import 'package:tv_randshow/core/migration/domain/use_cases/verify_old_database_use_case.dart';
import 'package:tv_randshow/ui/features/migration/migration_status_state.dart';

import 'migration_status_state_test.mocks.dart';

@GenerateMocks([
  VerifyDatabaseUseCase,
  GetMigrationStatusUseCase,
  SaveMigrationStatusUseCase,
  VerifyOldDatabaseUseCase,
])
void main() {
  final faker = Faker();
  final verifyDatabaseUseCase = MockVerifyDatabaseUseCase();
  final getMigrationStatusUseCase = MockGetMigrationStatusUseCase();
  final saveMigrationStatusUseCase = MockSaveMigrationStatusUseCase();
  final verifyOldDatabaseUseCase = MockVerifyOldDatabaseUseCase();
  late MigrationStatusState webState;
  late MigrationStatusState mobileState;

  MigrationStatus getRandomStatus({
    List<MigrationStatus> excludedStatus = const [],
  }) {
    return faker.randomGenerator.element(
      MigrationStatus.values
          .where((element) => !excludedStatus.contains(element))
          .toList(),
    );
  }

  setUp(() {
    reset(verifyDatabaseUseCase);
    reset(getMigrationStatusUseCase);
    reset(saveMigrationStatusUseCase);
    webState = MigrationStatusState(
      isWeb: true,
      getMigrationStatusUseCase: getMigrationStatusUseCase,
      saveMigrationStatusUseCase: saveMigrationStatusUseCase,
      verifyDatabaseUseCase: verifyDatabaseUseCase,
    );
    mobileState = MigrationStatusState(
      isWeb: false,
      getMigrationStatusUseCase: getMigrationStatusUseCase,
      saveMigrationStatusUseCase: saveMigrationStatusUseCase,
      verifyDatabaseUseCase: verifyDatabaseUseCase,
      verifyOldDatabaseUseCase: verifyOldDatabaseUseCase,
    );
  });
  group('is web', () {
    group('loadStatus', () {
      test(
        'when migration status is complete then return immediately',
        () async {
          when(
            getMigrationStatusUseCase(),
          ).thenAnswer((_) async => MigrationStatus.complete);

          await webState.loadStatus();

          expect(webState.completeMigration, isTrue);

          when(
            getMigrationStatusUseCase(),
          ).thenAnswer((_) async => MigrationStatus.empty);

          await webState.loadStatus();

          verify(getMigrationStatusUseCase()).called(2);
          expect(webState.completeMigration, isTrue);
        },
      );
      test(
        'when migration status is not complete or empty then complete migration is false',
        () async {
          when(getMigrationStatusUseCase()).thenAnswer(
            (_) async => getRandomStatus(
              excludedStatus: [MigrationStatus.complete, MigrationStatus.empty],
            ),
          );
          when(verifyDatabaseUseCase()).thenAnswer((_) async => false);

          await webState.loadStatus();

          verify(getMigrationStatusUseCase()).called(1);
          verify(verifyDatabaseUseCase()).called(1);
          expect(webState.completeMigration, isFalse);
        },
      );
      test(
        'when migration status empty on verification database then complete migration is true',
        () async {
          when(getMigrationStatusUseCase()).thenAnswer(
            (_) async => getRandomStatus(
              excludedStatus: [MigrationStatus.complete, MigrationStatus.empty],
            ),
          );
          when(verifyDatabaseUseCase()).thenAnswer((_) async => true);

          await webState.loadStatus();

          verify(getMigrationStatusUseCase()).called(1);
          verify(verifyDatabaseUseCase()).called(1);
          expect(webState.completeMigration, isTrue);
        },
      );
    });
    group('saveStatus', () {
      test('when status is different that init then save it', () async {
        final MigrationStatus status = getRandomStatus(
          excludedStatus: [MigrationStatus.init],
        );
        when(saveMigrationStatusUseCase(status)).thenAnswer((_) async => true);

        await webState.saveStatus(status);

        verify(saveMigrationStatusUseCase(status)).called(1);
        expect(webState.migration, status);
      });
      test('when status is init then do nothing', () async {
        const MigrationStatus status0 = MigrationStatus.init;
        when(
          saveMigrationStatusUseCase(status0),
        ).thenAnswer((_) async => false);

        await webState.saveStatus(status0);

        verifyNever(saveMigrationStatusUseCase(status0));
        expect(webState.migration, status0);
      });
    });
  });
  group('is mobile', () {
    group('loadStatus', () {
      test(
        'when migration status is complete then return immediately',
        () async {
          when(
            getMigrationStatusUseCase(),
          ).thenAnswer((_) async => MigrationStatus.complete);

          await mobileState.loadStatus();

          expect(mobileState.completeMigration, isTrue);

          when(
            getMigrationStatusUseCase(),
          ).thenAnswer((_) async => MigrationStatus.empty);

          await mobileState.loadStatus();

          verify(getMigrationStatusUseCase()).called(2);
          expect(mobileState.completeMigration, isTrue);
        },
      );
      test(
        'when migration status is not complete or empty then complete migration is false',
        () async {
          when(getMigrationStatusUseCase()).thenAnswer(
            (_) async => getRandomStatus(
              excludedStatus: [MigrationStatus.complete, MigrationStatus.empty],
            ),
          );
          when(verifyDatabaseUseCase()).thenAnswer((_) async => false);
          when(
            saveMigrationStatusUseCase(MigrationStatus.completeDatabase),
          ).thenAnswer((_) async => true);

          await mobileState.loadStatus();

          verify(getMigrationStatusUseCase()).called(1);
          verify(verifyDatabaseUseCase()).called(1);
          verify(
            saveMigrationStatusUseCase(MigrationStatus.completeDatabase),
          ).called(1);
          expect(mobileState.completeMigration, isFalse);
        },
      );
      group('verify old database', () {
        test(
          'when old database is empty then migration status is empty',
          () async {
            when(getMigrationStatusUseCase()).thenAnswer(
              (_) async => getRandomStatus(
                excludedStatus: [
                  MigrationStatus.complete,
                  MigrationStatus.empty,
                ],
              ),
            );
            when(verifyDatabaseUseCase()).thenAnswer((_) async => true);
            when(verifyOldDatabaseUseCase()).thenAnswer((_) async => true);
            when(
              saveMigrationStatusUseCase(MigrationStatus.empty),
            ).thenAnswer((_) async => true);

            await mobileState.loadStatus();

            verify(getMigrationStatusUseCase()).called(1);
            verify(verifyDatabaseUseCase()).called(1);
            verify(verifyOldDatabaseUseCase()).called(1);
            verify(saveMigrationStatusUseCase(MigrationStatus.empty)).called(1);
            verifyNever(
              saveMigrationStatusUseCase(MigrationStatus.completeDatabase),
            );
            expect(mobileState.migration, MigrationStatus.empty);
          },
        );
        test(
          'when old database is not empty then return immediately',
          () async {
            final status = getRandomStatus(
              excludedStatus: [MigrationStatus.complete, MigrationStatus.empty],
            );
            when(getMigrationStatusUseCase()).thenAnswer((_) async => status);
            when(verifyDatabaseUseCase()).thenAnswer((_) async => true);
            when(verifyOldDatabaseUseCase()).thenAnswer((_) async => false);
            when(
              saveMigrationStatusUseCase(MigrationStatus.init),
            ).thenAnswer((_) async => true);

            await mobileState.loadStatus();

            verify(getMigrationStatusUseCase()).called(1);
            verify(verifyDatabaseUseCase()).called(1);
            verify(verifyOldDatabaseUseCase()).called(1);
            verifyNever(
              saveMigrationStatusUseCase(MigrationStatus.completeDatabase),
            );
            expect(mobileState.migration, status);
          },
        );
      });
    });
    group('saveStatus', () {
      test('when status is different that init then save it', () async {
        final MigrationStatus status = getRandomStatus(
          excludedStatus: [MigrationStatus.init],
        );
        when(saveMigrationStatusUseCase(status)).thenAnswer((_) async => true);

        await mobileState.saveStatus(status);

        verify(saveMigrationStatusUseCase(status)).called(1);
        expect(mobileState.migration, status);
      });
      test('when status is init then do nothing', () async {
        const MigrationStatus status0 = MigrationStatus.init;
        when(
          saveMigrationStatusUseCase(status0),
        ).thenAnswer((_) async => false);

        await mobileState.saveStatus(status0);

        verifyNever(saveMigrationStatusUseCase(status0));
        expect(mobileState.migration, status0);
      });
    });
  });
}
