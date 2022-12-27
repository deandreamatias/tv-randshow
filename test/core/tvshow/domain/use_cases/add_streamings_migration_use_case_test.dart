import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_randshow/core/models/season.dart';
import 'package:tv_randshow/core/models/tvshow_details.dart';
import 'package:tv_randshow/core/services/databases/i_database_service.dart';
import 'package:tv_randshow/core/streaming/domain/interfaces/i_streamings_repository.dart';
import 'package:tv_randshow/core/streaming/domain/models/streaming.dart';
import 'package:tv_randshow/core/streaming/domain/models/streaming_search.dart';
import 'package:tv_randshow/core/tvshow/domain/models/migration_status.dart';
import 'package:tv_randshow/core/tvshow/domain/use_cases/add_streamings_migration_use_case.dart';

import 'add_streamings_migration_use_case_test.mocks.dart';

@GenerateMocks([IDatabaseService, IStreamingsRepository])
void main() {
  final faker = Faker();
  final streamings = () => List.generate(
        faker.randomGenerator.integer(20),
        (index) => StreamingDetail(
          id: faker.randomGenerator.integer(9999).toString(),
          country: faker.address.country(),
          leaving: faker.randomGenerator.integer(1),
          added: faker.randomGenerator.integer(1),
          streamingName: faker.lorem.word(),
        ),
      );
  final streaming = () => Streaming(
        imdbRating: faker.randomGenerator.integer(100),
        imdbVoteCount: faker.randomGenerator.integer(9999),
        tmdbRating: faker.randomGenerator.integer(100),
        year: DateTime.now().year,
        firstAirYear: DateTime.now().year,
        lastAirYear: DateTime.now().year,
        seasons: faker.randomGenerator.integer(50),
        episodes: faker.randomGenerator.integer(9999),
        age: faker.randomGenerator.integer(100),
        status: faker.randomGenerator.integer(1),
        streamings: streamings(),
      );
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
        streamings: withStreamings ? streamings() : [],
        rowId:
            faker.randomGenerator.integer(faker.randomGenerator.integer(999)),
        seasons: List.generate(faker.randomGenerator.integer(50),
            (index) => Season(id: faker.randomGenerator.integer(9999))),
      );

  final _databaseService = MockIDatabaseService();
  final _streamingsRepository = MockIStreamingsRepository();

  final usecase = AddStreamingsMigrationUseCase(
    _databaseService,
    _streamingsRepository,
  );

  setUp(() {
    reset(_databaseService);
    reset(_streamingsRepository);
  });
  group('complete -', () {
    test('Should return complete status when has empty database', () async {
      when(_databaseService.getTvshows()).thenAnswer((_) async => []);

      expect(usecase(), emits(MigrationStatus.empty));
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
    });
    test('Should return complete status when save all tvshows with streamings',
        () async {
      final tvshows = random.amount<TvshowDetails>((i) => tvshowDetails(), 50);
      when(_databaseService.getTvshows()).thenAnswer((_) async => tvshows);

      tvshows.forEach((tvshow) {
        final _streaming = streaming();

        when(_streamingsRepository.searchTvShow(argThat(isNotNull))).thenAnswer(
          (_) async => _streaming,
        );

        final _tvshow = tvshow.copyWith(
            streamings: _streaming.streamings, rowId: tvshow.rowId);
        when(_databaseService.saveStreamings(_tvshow))
            .thenAnswer((_) async => null);
      });

      expect(
          usecase(),
          emitsInOrder([
            ...List.generate(
              tvshows.length,
              (index) => MigrationStatus.addStreaming,
            ),
            MigrationStatus.complete
          ]));
      expect(
        usecase(),
        neverEmits(isA<Exception>()),
      );
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
    test(
        'Should get exception when has exception on search streamings tv shows',
        () async {
      final exception = Exception('Error to get tvshows');
      final tvshows = random.amount<TvshowDetails>((i) => tvshowDetails(), 50);
      when(_databaseService.getTvshows()).thenAnswer((_) async => tvshows);

      tvshows.forEach((tvshow) {
        when(_streamingsRepository.searchTvShow(
          argThat(isA<StreamingSearch>().having((search) => search.tmdbId,
              'tmdbId', equals(tvshow.id.toString()))),
        )).thenThrow(exception);
      });

      usecase().listen(
        (value) {},
        onError: expectAsync1(
          (value) => expect(value, exception),
        ),
        onDone: () {
          verify(_databaseService.getTvshows()).called(1);
          verify(_streamingsRepository.searchTvShow(any)).called(1);
        },
      );
    });
    test('Should get exception when has exception on save streamings tv shows',
        () async {
      final exception = Exception('Error to get tvshows');
      final tvshows = random.amount<TvshowDetails>((i) => tvshowDetails(), 50);
      when(_databaseService.getTvshows()).thenAnswer((_) async => tvshows);

      tvshows.forEach((tvshow) {
        final _streaming = streaming();

        when(_streamingsRepository.searchTvShow(argThat(isNotNull))).thenAnswer(
          (_) async => _streaming,
        );

        when(_databaseService.saveStreamings(
          argThat(isA<TvshowDetails>().having(
              (tvshowDetail) => tvshowDetail.id, 'id', equals(tvshow.id))),
        )).thenThrow(exception);
      });

      usecase().listen(
        (value) {},
        onError: expectAsync1(
          (value) => expect(value, exception),
        ),
        onDone: () {
          verify(_databaseService.getTvshows()).called(1);
          verify(_streamingsRepository.searchTvShow(any)).called(1);
          verify(_databaseService.saveStreamings(any)).called(1);
        },
      );
    });
  });
}
