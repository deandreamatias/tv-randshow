// ignore_for_file: avoid-ignoring-return-values, no-magic-number, no-equal-arguments
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_randshow/core/migration/domain/models/migration_status.dart';
import 'package:tv_randshow/core/migration/domain/use_cases/add_streamings_migration_use_case.dart';
import 'package:tv_randshow/core/streaming/domain/interfaces/i_streamings_repository.dart';
import 'package:tv_randshow/core/streaming/domain/models/streaming.dart';
import 'package:tv_randshow/core/streaming/domain/models/streaming_search.dart';
import 'package:tv_randshow/core/tvshow/domain/interfaces/i_local_repository.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_details.dart';

import 'add_streamings_migration_use_case_test.mocks.dart';

@GenerateMocks([ILocalRepository, IStreamingsRepository])
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
  TvshowDetails tvshowDetails({bool withStreamings = false}) => TvshowDetails(
    episodeRunTime: faker.randomGenerator.numbers(
      1000,
      faker.randomGenerator.integer(999),
    ),
    id: faker.randomGenerator.integer(9999),
    inProduction: faker.randomGenerator.boolean() ? 1 : 0,
    name: faker.lorem.sentence(),
    numberOfEpisodes: faker.randomGenerator.integer(999),
    numberOfSeasons: faker.randomGenerator.integer(50),
    overview: faker.lorem.sentence(),
    posterPath: faker.internet.httpsUrl(),
    streamings: withStreamings ? streamings() : [],
    rowId: faker.randomGenerator.integer(faker.randomGenerator.integer(999)),
  );

  final localRepository = MockILocalRepository();
  final streamingsRepository = MockIStreamingsRepository();

  final usecase = AddStreamingsMigrationUseCase(
    localRepository,
    streamingsRepository,
  );

  setUp(() {
    reset(localRepository);
    reset(streamingsRepository);
  });
  group('complete -', () {
    test('Should return complete status when has empty database', () {
      when(localRepository.getTvshows()).thenAnswer((_) async => []);

      expect(usecase(), emits(MigrationStatus.empty));
      expect(usecase(), neverEmits(isA<Exception>()));
    });

    test(
      'Should return complete status when has tvshows with empty streamings',
      () {
        final tvshows = random.amount<TvshowDetails>(
          (i) => tvshowDetails(withStreamings: true),
          50,
        );
        when(localRepository.getTvshows()).thenAnswer((_) async => tvshows);

        expect(usecase(), emits(MigrationStatus.complete));
        expect(usecase(), neverEmits(isA<Exception>()));
      },
    );
    test(
      'Should return complete status when save all tvshows with streamings',
      () {
        final tvshows = random.amount<TvshowDetails>(
          (i) => tvshowDetails(),
          50,
        );
        when(localRepository.getTvshows()).thenAnswer((_) async => tvshows);

        for (TvshowDetails tvshow in tvshows) {
          final localStreaming = streamings();

          when(
            streamingsRepository.searchTvShow(argThat(isNotNull)),
          ).thenAnswer((_) async => localStreaming);

          final localTvshow = tvshow.copyWith(
            streamings: localStreaming,
            rowId: tvshow.rowId,
          );
          when(
            localRepository.saveStreamings(localTvshow),
          ).thenAnswer((_) async => Future<void>);
        }

        expect(
          usecase(),
          emitsInOrder([
            ...List.generate(
              tvshows.length,
              (index) => MigrationStatus.addStreaming,
            ),
            MigrationStatus.complete,
          ]),
        );
        expect(usecase(), neverEmits(isA<Exception>()));
      },
    );
  });
  group('errors -', () {
    test('Should get exception when has exception on get tv shows', () {
      final exception = Exception('Error to get tvshows');
      when(localRepository.getTvshows()).thenThrow(exception);

      usecase().listen(
        (value) => {},
        onError: expectAsync1((value) => expect(value, exception)),
        onDone: () {
          verify(localRepository.getTvshows()).called(1);
        },
      );
    });
    test(
      'Should get exception when has exception on search streamings tv shows',
      () {
        final exception = Exception('Error to get tvshows');
        final tvshows = random.amount<TvshowDetails>(
          (i) => tvshowDetails(),
          50,
        );
        when(localRepository.getTvshows()).thenAnswer((_) async => tvshows);

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
          (value) => {},
          onError: expectAsync1((value) => expect(value, exception)),
          onDone: () {
            verify(localRepository.getTvshows()).called(1);
            verify(streamingsRepository.searchTvShow(any)).called(1);
          },
        );
      },
    );
    test(
      'Should get exception when has exception on save streamings tv shows',
      () {
        final exception = Exception('Error to get tvshows');
        final tvshows = random.amount<TvshowDetails>(
          (i) => tvshowDetails(),
          50,
        );
        when(localRepository.getTvshows()).thenAnswer((_) async => tvshows);

        for (var tvshow in tvshows) {
          final streaming0 = streamings();

          when(
            streamingsRepository.searchTvShow(argThat(isNotNull)),
          ).thenAnswer((_) async => streaming0);

          when(
            localRepository.saveStreamings(
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
          (value) => {},
          onError: expectAsync1((value) => expect(value, exception)),
          onDone: () {
            verify(localRepository.getTvshows()).called(1);
            verify(streamingsRepository.searchTvShow(any)).called(1);
            verify(localRepository.saveStreamings(any)).called(1);
          },
        );
      },
    );
  });
}
