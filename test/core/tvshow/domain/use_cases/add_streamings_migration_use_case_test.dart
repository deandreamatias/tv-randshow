import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_randshow/core/migration/domain/models/migration_status.dart';
import 'package:tv_randshow/core/migration/domain/use_cases/add_streamings_migration_use_case.dart';
import 'package:tv_randshow/core/streaming/domain/interfaces/i_streamings_repository.dart';
import 'package:tv_randshow/core/streaming/domain/models/streaming.dart';
import 'package:tv_randshow/core/streaming/domain/models/streaming_search.dart';
import 'package:tv_randshow/core/tvshow/domain/interfaces/i_database_repository.dart';
import 'package:tv_randshow/core/tvshow/domain/models/season.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_details.dart';

import 'add_streamings_migration_use_case_test.mocks.dart';

@GenerateMocks([IDatabaseRepository, IStreamingsRepository])
void main() {
  final faker = Faker();
  List<StreamingDetail> streamings() => List.generate(
        faker.randomGenerator.integer(20),
        (index) => StreamingDetail(
          id: faker.randomGenerator.integer(9999).toString(),
          country: faker.address.country(),
          leaving: faker.randomGenerator.integer(1),
          added: faker.randomGenerator.integer(1),
          streamingName: faker.lorem.word(),
        ),
      );
  Streaming streaming() => Streaming(
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
  TvshowDetails tvshowDetails({bool withStreamings = false}) => TvshowDetails(
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
        seasons: List.generate(
          faker.randomGenerator.integer(50),
          (index) => Season(id: faker.randomGenerator.integer(9999)),
        ),
      );

  final databaseService = MockIDatabaseRepository();
  final streamingsRepository = MockIStreamingsRepository();

  final usecase = AddStreamingsMigrationUseCase(
    databaseService,
    streamingsRepository,
  );

  setUp(() {
    reset(databaseService);
    reset(streamingsRepository);
  });
  group('complete -', () {
    test('Should return complete status when has empty database', () async {
      when(databaseService.getTvshows()).thenAnswer((_) async => []);

      expect(usecase(), emits(MigrationStatus.empty));
      expect(
        usecase(),
        neverEmits(isA<Exception>()),
      );
    });

    test('Should return complete status when has tvshows with empty streamings',
        () async {
      final tvshows = random.amount<TvshowDetails>(
        (i) => tvshowDetails(withStreamings: true),
        50,
      );
      when(databaseService.getTvshows()).thenAnswer((_) async => tvshows);

      expect(usecase(), emits(MigrationStatus.complete));
      expect(
        usecase(),
        neverEmits(isA<Exception>()),
      );
    });
    test('Should return complete status when save all tvshows with streamings',
        () async {
      final tvshows = random.amount<TvshowDetails>((i) => tvshowDetails(), 50);
      when(databaseService.getTvshows()).thenAnswer((_) async => tvshows);

      for (TvshowDetails tvshow in tvshows) {
        final localStreaming = streaming();

        when(streamingsRepository.searchTvShow(argThat(isNotNull))).thenAnswer(
          (_) async => localStreaming,
        );

        final localTvshow = tvshow.copyWith(
          streamings: localStreaming.streamings,
          rowId: tvshow.rowId,
        );
        when(databaseService.saveStreamings(localTvshow))
            .thenAnswer((_) async => Future<void>);
      }

      expect(
        usecase(),
        emitsInOrder([
          ...List.generate(
            tvshows.length,
            (index) => MigrationStatus.addStreaming,
          ),
          MigrationStatus.complete
        ]),
      );
      expect(
        usecase(),
        neverEmits(isA<Exception>()),
      );
    });
  });
  group('errors -', () {
    test('Should get exception when has exception on get tv shows', () async {
      final exception = Exception('Error to get tvshows');
      when(databaseService.getTvshows()).thenThrow(exception);

      usecase().listen(
        (value) {},
        onError: expectAsync1(
          (value) => expect(value, exception),
        ),
        onDone: () {
          verify(databaseService.getTvshows()).called(1);
        },
      );
    });
    test(
        'Should get exception when has exception on search streamings tv shows',
        () async {
      final exception = Exception('Error to get tvshows');
      final tvshows = random.amount<TvshowDetails>((i) => tvshowDetails(), 50);
      when(databaseService.getTvshows()).thenAnswer((_) async => tvshows);

      for (var tvshow in tvshows) {
        when(
          streamingsRepository.searchTvShow(
            argThat(
              isA<StreamingSearch>().having(
                (search) => search.tmdbId,
                'tmdbId',
                equals(tvshow.id.toString()),
              ),
            ),
          ),
        ).thenThrow(exception);
      }

      usecase().listen(
        (value) {},
        onError: expectAsync1(
          (value) => expect(value, exception),
        ),
        onDone: () {
          verify(databaseService.getTvshows()).called(1);
          verify(streamingsRepository.searchTvShow(any)).called(1);
        },
      );
    });
    test('Should get exception when has exception on save streamings tv shows',
        () async {
      final exception = Exception('Error to get tvshows');
      final tvshows = random.amount<TvshowDetails>((i) => tvshowDetails(), 50);
      when(databaseService.getTvshows()).thenAnswer((_) async => tvshows);

      for (var tvshow in tvshows) {
        final streaming0 = streaming();

        when(streamingsRepository.searchTvShow(argThat(isNotNull))).thenAnswer(
          (_) async => streaming0,
        );

        when(
          databaseService.saveStreamings(
            argThat(
              isA<TvshowDetails>().having(
                (tvshowDetail) => tvshowDetail.id,
                'id',
                equals(tvshow.id),
              ),
            ),
          ),
        ).thenThrow(exception);
      }

      usecase().listen(
        (value) {},
        onError: expectAsync1(
          (value) => expect(value, exception),
        ),
        onDone: () {
          verify(databaseService.getTvshows()).called(1);
          verify(streamingsRepository.searchTvShow(any)).called(1);
          verify(databaseService.saveStreamings(any)).called(1);
        },
      );
    });
  });
}
