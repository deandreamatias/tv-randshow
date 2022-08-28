import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_randshow/core/models/season.dart';
import 'package:tv_randshow/core/models/tvshow_details.dart';
import 'package:tv_randshow/core/services/databases/i_database_service.dart';
import 'package:tv_randshow/core/services/databases/i_secondary_database_service.dart';
import 'package:tv_randshow/core/tvshow/domain/models/migration_status.dart';
import 'package:tv_randshow/core/tvshow/domain/use_cases/mobile_database_migration_use_case.dart';

import 'mobile_database_migration_use_case_test.mocks.dart';

@GenerateMocks([IDatabaseService, ISecondaryDatabaseService])
void main() {
  final faker = Faker();
  final tvshowDetails = () => TvshowDetails(
        episodeRunTime: faker.randomGenerator
            .numbers(1000, faker.randomGenerator.integer(999)),
        id: faker.randomGenerator.integer(9999),
        inProduction: faker.randomGenerator.boolean() ? 1 : 0,
        name: faker.lorem.sentence(),
        numberOfEpisodes: faker.randomGenerator.integer(999),
        numberOfSeasons: faker.randomGenerator.integer(50),
        overview: faker.lorem.sentence(),
        posterPath: faker.internet.uri('http'),
        rowId:
            faker.randomGenerator.integer(faker.randomGenerator.integer(999)),
        seasons: List.generate(faker.randomGenerator.integer(50),
            (index) => Season(id: faker.randomGenerator.integer(9999))),
      );

  final _databaseService = MockIDatabaseService();
  final _secondaryDatabaseService = MockISecondaryDatabaseService();
  final usecase = MobileDatabaseMigrationUseCase(
    _databaseService,
    _secondaryDatabaseService,
  );

  group('emptyOld -', () {
    test('Should return emptyOld status when has empty database', () async {
      when(_secondaryDatabaseService.getTvshows()).thenAnswer((_) async => []);

      final result = await usecase();

      expect(result.status, MigrationStatus.emptyOld);
      expect(result.error, isEmpty);
    });
  });
  group('completeDatabase -', () {
    test('Should return completeDatabase status when dont has errors',
        () async {
      final tvshows = random.amount<TvshowDetails>((i) => tvshowDetails(), 50);

      when(_secondaryDatabaseService.getTvshows())
          .thenAnswer((_) async => tvshows);
      when(_databaseService.getTvshows()).thenAnswer((_) async => tvshows);
      tvshows.forEach((tvshow) {
        when(_databaseService.saveTvshow(tvshow)).thenAnswer((_) async => true);
      });
      when(_secondaryDatabaseService.deleteAll()).thenAnswer((_) async => true);

      final result = await usecase();

      expect(result.status, MigrationStatus.completeDatabase);
      expect(result.error, isEmpty);
    });
  });
  group('errors -', () {
    test('Should return loadedOld status and error when can save a one tv show',
        () async {
      final tvshows = random.amount<TvshowDetails>((i) => tvshowDetails(), 50);
      final index = random.integer(tvshows.length - 1);
      final errorTvshow = tvshows[index];

      when(_secondaryDatabaseService.getTvshows())
          .thenAnswer((_) async => tvshows);

      tvshows.forEach((tvshow) {
        when(_databaseService.saveTvshow(tvshow))
            .thenAnswer((_) async => errorTvshow.id != tvshow.id);
      });

      final result = await usecase();

      expect(result.status, MigrationStatus.loadedOld);
      expect(result.error, 'Error to save tv show ${errorTvshow.id}');
    });
    test(
        'Should return savedToNew status and error when has not equal database lists',
        () async {
      final tvshows = random.amount<TvshowDetails>((i) => tvshowDetails(), 50);
      final newTvshows =
          random.amount<TvshowDetails>((i) => tvshowDetails(), 50);

      when(_secondaryDatabaseService.getTvshows())
          .thenAnswer((_) async => tvshows);
      when(_databaseService.getTvshows()).thenAnswer((_) async => newTvshows);
      tvshows.forEach((tvshow) {
        when(_databaseService.saveTvshow(tvshow)).thenAnswer((_) async => true);
      });

      final result = await usecase();

      expect(result.status, MigrationStatus.savedToNew);
      expect(result.error, 'Error on database verification');
    });
    test(
        'Should return verifyData status and error when can delete old database',
        () async {
      final tvshows = random.amount<TvshowDetails>((i) => tvshowDetails(), 50);

      when(_secondaryDatabaseService.getTvshows())
          .thenAnswer((_) async => tvshows);
      when(_databaseService.getTvshows()).thenAnswer((_) async => tvshows);
      tvshows.forEach((tvshow) {
        when(_databaseService.saveTvshow(tvshow)).thenAnswer((_) async => true);
      });
      when(_secondaryDatabaseService.deleteAll())
          .thenAnswer((_) async => false);

      final result = await usecase();

      expect(result.status, MigrationStatus.verifyData);
      expect(result.error, 'Error to delete old database');
    });
  });
}
