import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_randshow/core/models/season.dart';
import 'package:tv_randshow/core/models/tvshow_details.dart';
import 'package:tv_randshow/core/services/databases/i_database_service.dart';
import 'package:tv_randshow/core/streaming/domain/models/streaming.dart';
import 'package:tv_randshow/core/streaming/domain/use_cases/get_tvshow_streamings_use_case.dart';
import 'package:tv_randshow/core/tvshow/domain/models/migration_status.dart';
import 'package:tv_randshow/core/tvshow/domain/use_cases/add_streamings_migration_use_case.dart';

import 'add_streamings_migration_use_case_test.mocks.dart';

@GenerateMocks([IDatabaseService, GetTvshowStreamingsUseCase])
void main() {
  final faker = Faker();
  final tvshowDetails = ([bool withStreamings = false]) => TvshowDetails(
        episodeRunTime: faker.randomGenerator
            .numbers(1000, faker.randomGenerator.integer(999)),
        id: faker.randomGenerator.integer(9999),
        inProduction: faker.randomGenerator.boolean() ? 1 : 0,
        name: faker.lorem.sentence(),
        numberOfEpisodes: faker.randomGenerator.integer(999),
        numberOfSeasons: faker.randomGenerator.integer(50),
        overview: faker.lorem.sentence(),
        posterPath: faker.internet.httpsUrl(),
        streamings: withStreamings
            ? List.generate(
                faker.randomGenerator.integer(50),
                (index) => StreamingDetail(
                      id: faker.randomGenerator.integer(9999).toString(),
                      country: faker.address.country(),
                      leaving: faker.randomGenerator.integer(1),
                      added: faker.randomGenerator.integer(1),
                      streamingName: faker.lorem.word(),
                    ))
            : [],
        rowId:
            faker.randomGenerator.integer(faker.randomGenerator.integer(999)),
        seasons: List.generate(faker.randomGenerator.integer(50),
            (index) => Season(id: faker.randomGenerator.integer(9999))),
      );

  final _databaseService = MockIDatabaseService();
  final _getTvshowStreamingsUseCase = MockGetTvshowStreamingsUseCase();

  final usecase = AddStreamingsMigrationUseCase(
    _databaseService,
    _getTvshowStreamingsUseCase,
  );

  setUp(() {
    reset(_databaseService);
  });
  group('complete -', () {
    test('Should return complete status when has empty database', () async {
      when(_databaseService.getTvshows()).thenAnswer((_) async => []);

      expect(usecase(), emits(MigrationStatus.complete));
      expect(
        usecase(),
        neverEmits(isA<Exception>()),
      );
    });
    test('Should return complete status when has tvshows with empty streamings',
        () async {
      final tvshows =
          random.amount<TvshowDetails>((i) => tvshowDetails(true), 50);
      when(_databaseService.getTvshows()).thenAnswer((_) async => tvshows);

      expect(usecase(), emits(MigrationStatus.complete));
      expect(
        usecase(),
        neverEmits(isA<Exception>()),
      );
      // TODO: Test get MigrationStatus.addStreaming on each test
      // TODO: Test get MigrationStatus.complete when save all streamings
    });
  });
  group('errors -', () {
    test('Should get exception when has exception on get tv shows', () async {
      final exception = Exception('Error to get tvshows');
      when(_databaseService.getTvshows()).thenThrow(exception);

      usecase().listen(
        (value) {},
        onError: expectAsync1(
          (value) => expect(value, exception),
        ),
        onDone: () {
          verify(_databaseService.getTvshows()).called(1);
        },
      );
    });
    // TODO: Test get exception on call _getTvshowStreamingsUseCase
    // TODO: Test get exception when try save streamings
  });
}
