// ignore_for_file: avoid-ignoring-return-values
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_randshow/core/migration/domain/models/migration_status.dart';
import 'package:tv_randshow/core/migration/domain/use_cases/mobile_database_migration_use_case.dart';
import 'package:tv_randshow/core/tvshow/domain/interfaces/i_local_repository.dart';
import 'package:tv_randshow/core/tvshow/domain/interfaces/i_secondary_database_service.dart';

import '../../../../helpers/generate_tvshow.dart';
import 'mobile_database_migration_use_case_test.mocks.dart';

@GenerateMocks([ILocalRepository, ISecondaryDatabaseService])
void main() {
  final generateTvshow = GenerateTvshow();

  final localRepository = MockILocalRepository();
  final secondaryDatabaseService = MockISecondaryDatabaseService();
  final usecase = MobileDatabaseMigrationUseCase(
    localRepository,
    secondaryDatabaseService,
  );

  setUp(() {
    reset(localRepository);
    reset(secondaryDatabaseService);
  });

  group('emptyOld -', () {
    test('Should return emptyOld status when has empty database', () {
      when(secondaryDatabaseService.getTvshows()).thenAnswer((_) async => []);

      expect(
        usecase(),
        emitsInOrder([
          MigrationStatus.loadedOld,
          MigrationStatus.empty,
        ]),
      );
      expect(
        usecase(),
        neverEmits(isA<Exception>()),
      );
    });
  });
  group('completeDatabase -', () {
    test(
      'Should return completeDatabase status when dont has errors',
      () {
        final tvshows = generateTvshow.tvshows;

        when(secondaryDatabaseService.getTvshows())
            .thenAnswer((_) async => tvshows);
        when(localRepository.getTvshows()).thenAnswer((_) async => tvshows);
        for (var tvshow in tvshows) {
          when(localRepository.saveTvshow(tvshow))
              .thenAnswer((_) async => true);
        }
        when(secondaryDatabaseService.deleteAll())
            .thenAnswer((_) async => true);

        expect(
          usecase(),
          emitsInOrder([
            MigrationStatus.loadedOld,
            MigrationStatus.savedToNew,
            MigrationStatus.verifyData,
            MigrationStatus.deletedOld,
            MigrationStatus.completeDatabase,
          ]),
        );
        expect(
          usecase(),
          neverEmits(isA<Exception>()),
        );
      },
    );
  });
  group('errors -', () {
    test(
      'Should return loadedOld status and error when can save a one tv show',
      () {
        final tvshows = generateTvshow.tvshows;
        final index = random.integer(tvshows.length - 1);
        final errorTvshow = tvshows[index];
        final exception = Exception('Error to save tvshow ${errorTvshow.id}');

        when(secondaryDatabaseService.getTvshows())
            .thenAnswer((_) async => tvshows);

        for (var tvshow in tvshows) {
          if (tvshow.id != errorTvshow.id) {
            when(localRepository.saveTvshow(tvshow))
                .thenAnswer((_) => Future.value());
          } else {
            when(localRepository.saveTvshow(tvshow)).thenThrow(exception);
          }
        }
        usecase().listen(
          expectAsync1(
            (value) => expect(value, MigrationStatus.loadedOld),
          ),
          onError: expectAsync1(
            (value) => expect(value, exception),
          ),
          onDone: () {
            verify(secondaryDatabaseService.getTvshows()).called(1);
            verify(localRepository.saveTvshow(errorTvshow)).called(1);
          },
        );
      },
    );
    test(
      'Should return savedToNew status and error when has not equal database lists',
      () {
        final tvshows = generateTvshow.tvshows;
        final newTvshows = generateTvshow.tvshows;
        final exception = Exception('Differences between old and new database');

        when(secondaryDatabaseService.getTvshows())
            .thenAnswer((_) async => tvshows);
        when(localRepository.getTvshows()).thenAnswer((_) async => newTvshows);
        for (var tvshow in tvshows) {
          when(localRepository.saveTvshow(tvshow))
              .thenAnswer((_) => Future.value());
        }

        usecase().listen(
          expectAsync1(
            (value) => expect(
              [MigrationStatus.loadedOld, MigrationStatus.savedToNew]
                  .contains(value),
              true,
            ),
            count: 2,
          ),
          onError: expectAsync1(
            (value) => expect(value.toString(), exception.toString()),
          ),
          onDone: () {
            verify(secondaryDatabaseService.getTvshows()).called(1);
            verify(localRepository.saveTvshow(tvshows.first)).called(1);
            verify(localRepository.getTvshows()).called(1);
          },
        );
      },
    );
    test(
      'Should return verifyData status and error when can delete old database',
      () {
        final tvshows = generateTvshow.tvshows;
        final exception = Exception('Can not delete old database');

        when(secondaryDatabaseService.getTvshows())
            .thenAnswer((_) async => tvshows);
        when(localRepository.getTvshows()).thenAnswer((_) async => tvshows);
        for (var tvshow in tvshows) {
          when(localRepository.saveTvshow(tvshow))
              .thenAnswer((_) async => true);
        }
        when(secondaryDatabaseService.deleteAll())
            .thenAnswer((_) async => false);

        usecase().listen(
          expectAsync1(
            (value) => expect(
              [
                MigrationStatus.loadedOld,
                MigrationStatus.savedToNew,
                MigrationStatus.verifyData,
              ].contains(value),
              true,
            ),
            count: 3,
          ),
          onError: expectAsync1(
            (value) => expect(value.toString(), exception.toString()),
          ),
          onDone: () {
            verify(secondaryDatabaseService.getTvshows()).called(1);
            verify(localRepository.saveTvshow(tvshows.first)).called(1);
            verify(localRepository.getTvshows()).called(1);
            verify(secondaryDatabaseService.deleteAll()).called(1);
          },
        );
      },
    );
  });
}
