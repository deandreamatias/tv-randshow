import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_randshow/core/models/file.dart';
import 'package:tv_randshow/core/models/season.dart';
import 'package:tv_randshow/core/models/tvshow_details.dart';
import 'package:tv_randshow/core/services/app_service.dart';
import 'package:tv_randshow/core/services/databases/i_database_service.dart';
import 'package:tv_randshow/core/services/manage_files_service.dart';

import 'manage_files_service_test.mocks.dart';

@GenerateMocks([IDatabaseService, AppService])
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
        posterPath: faker.internet.uri('http'),
        rowId:
            faker.randomGenerator.integer(faker.randomGenerator.integer(999)),
        seasons: List.generate(
          faker.randomGenerator.integer(50),
          (index) => Season(id: faker.randomGenerator.integer(9999)),
        ),
      );
  final databaseService = MockIDatabaseService();
  final appService = MockAppService();
  final manageFiles = ManageFilesService(
    databaseService: databaseService,
    appService: appService,
  );

  test('should empty download path when init service', () {
    expect(manageFiles.downloadPath.isEmpty, isTrue);
  });
  group('saveTvshows -', () {
    test('should save tv shows when save tvshows', () async {
      final tvshows = random.amount<TvshowDetails>((i) => tvshowDetails(), 50);
      final nowDateTime = DateTime.now().toLocal().toIso8601String().split('.');
      final fileName = 'tvrandshow-${nowDateTime[0]}';
      when(databaseService.getTvshows()).thenAnswer((_) async => tvshows);
      when(appService.hasStoragePermission()).thenAnswer((_) async => true);
      when(
        appService.saveFile(
          fileName,
          TvshowsFile(tvshows: tvshows).toRawJson(),
        ),
      ).thenAnswer((_) async => fileName);

      expect(await manageFiles.saveTvshows(), isTrue);
    });
    test('should dont save tv shows when permission is denied', () async {
      final tvshows = random.amount<TvshowDetails>((i) => tvshowDetails(), 50);
      final nowDateTime = DateTime.now().toLocal().toIso8601String().split('.');
      final fileName = 'tvrandshow-${nowDateTime[0]}';
      when(databaseService.getTvshows()).thenAnswer((_) async => tvshows);
      when(appService.hasStoragePermission()).thenAnswer((_) async => false);
      when(
        appService.saveFile(
          fileName,
          TvshowsFile(tvshows: tvshows).toRawJson(),
        ),
      ).thenAnswer((_) async => fileName);

      expect(await manageFiles.saveTvshows(), isFalse);
    });
    test('should dont save tv shows when database is empty', () async {
      final nowDateTime = DateTime.now().toLocal().toIso8601String().split('.');
      final fileName = 'tvrandshow-${nowDateTime[0]}';
      when(databaseService.getTvshows()).thenAnswer((_) async => []);
      when(appService.hasStoragePermission()).thenAnswer((_) async => true);
      when(appService.saveFile(fileName, TvshowsFile(tvshows: []).toRawJson()))
          .thenAnswer((_) async => fileName);

      expect(await manageFiles.saveTvshows(), isFalse);
    });
    test('should dont save tv shows when file name is empty', () async {
      final tvshows = random.amount<TvshowDetails>((i) => tvshowDetails(), 50);
      final nowDateTime = DateTime.now().toLocal().toIso8601String().split('.');
      final fileName = 'tvrandshow-${nowDateTime[0]}';
      when(databaseService.getTvshows()).thenAnswer((_) async => tvshows);
      when(appService.hasStoragePermission()).thenAnswer((_) async => true);
      when(
        appService.saveFile(
          fileName,
          TvshowsFile(tvshows: tvshows).toRawJson(),
        ),
      ).thenAnswer((_) async => '');

      expect(await manageFiles.saveTvshows(), isFalse);
    });
  });
}
