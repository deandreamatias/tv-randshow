import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_randshow/core/migration/domain/models/migration_status.dart';
import 'package:tv_randshow/core/migration/domain/use_cases/mobile_database_migration_use_case.dart';
import 'package:tv_randshow/core/services/databases/i_database_service.dart';
import 'package:tv_randshow/core/services/databases/i_secondary_database_service.dart';
import 'package:tv_randshow/core/tvshow/domain/models/season.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_details.dart';

import 'mobile_database_migration_use_case_test.mocks.dart';

@GenerateMocks([IDatabaseService, ISecondaryDatabaseService])
void main() {
  final faker = Faker();
  TvshowDetails tvshowDetails() => TvshowDetails(
        episodeRunTime: faker.randomGenerator
            .numbers(1000, faker.randomGenerator.integer(999)),
        id: faker.randomGenerator.integer(9999),
        inProduction: faker.randomGenerator.boolean() ? 1 : 0,
        name: faker.lorem.sentence(),
        numberOfEpisodes: faker.randomGenerator.integer(999),
        numberOfSeasons: faker.randomGenerator.integer(50),
        overview: faker.lorem.sentence(),
        posterPath: faker.internet.httpsUrl(),
        rowId:
            faker.randomGenerator.integer(faker.randomGenerator.integer(999)),
        seasons: List.generate(
          faker.randomGenerator.integer(50),
          (index) => Season(id: faker.randomGenerator.integer(9999)),
        ),
      );

  final databaseService = MockIDatabaseService();
  final secondaryDatabaseService = MockISecondaryDatabaseService();
  final usecase = MobileDatabaseMigrationUseCase(
    databaseService,
    secondaryDatabaseService,
  );

  setUp(() {
    reset(databaseService);
    reset(secondaryDatabaseService);
  });

  group('emptyOld -', () {
    test('Should return emptyOld status when has empty database', () async {
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
    test('Should return completeDatabase status when dont has errors',
        () async {
      final tvshows = random.amount<TvshowDetails>((i) => tvshowDetails(), 50);

      when(secondaryDatabaseService.getTvshows())
          .thenAnswer((_) async => tvshows);
      when(databaseService.getTvshows()).thenAnswer((_) async => tvshows);
      for (var tvshow in tvshows) {
        when(databaseService.saveTvshow(tvshow)).thenAnswer((_) async => true);
      }
      when(secondaryDatabaseService.deleteAll()).thenAnswer((_) async => true);

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
    });
  });
  group('errors -', () {
    test('Should return loadedOld status and error when can save a one tv show',
        () async {
      final tvshows = random.amount<TvshowDetails>((i) => tvshowDetails(), 50);
      final index = random.integer(tvshows.length - 1);
      final errorTvshow = tvshows[index];
      final exception = Exception('Error to save tvshow ${errorTvshow.id}');

      when(secondaryDatabaseService.getTvshows())
          .thenAnswer((_) async => tvshows);

      for (var tvshow in tvshows) {
        if (tvshow.id != errorTvshow.id) {
          when(databaseService.saveTvshow(tvshow))
              .thenAnswer((_) async => Future.value());
        } else {
          when(databaseService.saveTvshow(tvshow)).thenThrow(exception);
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
          verify(databaseService.saveTvshow(errorTvshow)).called(1);
        },
      );
    });
    test(
        'Should return savedToNew status and error when has not equal database lists',
        () async {
      final tvshows = random.amount<TvshowDetails>((i) => tvshowDetails(), 50);
      final newTvshows =
          random.amount<TvshowDetails>((i) => tvshowDetails(), 50);
      final exception = Exception('Differences between old and new database');

      when(secondaryDatabaseService.getTvshows())
          .thenAnswer((_) async => tvshows);
      when(databaseService.getTvshows()).thenAnswer((_) async => newTvshows);
      for (var tvshow in tvshows) {
        when(databaseService.saveTvshow(tvshow))
            .thenAnswer((_) async => Future.value());
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
          verify(databaseService.saveTvshow(tvshows.first)).called(1);
          verify(databaseService.getTvshows()).called(1);
        },
      );
    });
    test(
        'Should return verifyData status and error when can delete old database',
        () async {
      final tvshows = random.amount<TvshowDetails>((i) => tvshowDetails(), 50);
      final exception = Exception('Can not delete old database');

      when(secondaryDatabaseService.getTvshows())
          .thenAnswer((_) async => tvshows);
      when(databaseService.getTvshows()).thenAnswer((_) async => tvshows);
      for (var tvshow in tvshows) {
        when(databaseService.saveTvshow(tvshow)).thenAnswer((_) async => true);
      }
      when(secondaryDatabaseService.deleteAll()).thenAnswer((_) async => false);

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
          verify(databaseService.saveTvshow(tvshows.first)).called(1);
          verify(databaseService.getTvshows()).called(1);
          verify(secondaryDatabaseService.deleteAll()).called(1);
        },
      );
    });
  });
}
