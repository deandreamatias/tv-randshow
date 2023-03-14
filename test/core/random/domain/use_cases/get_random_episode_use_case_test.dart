import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_randshow/core/app/domain/exceptions/app_error.dart';
import 'package:tv_randshow/core/random/domain/interfaces/i_random_service.dart';
import 'package:tv_randshow/core/random/domain/use_cases/get_random_episode_use_case.dart';
import 'package:tv_randshow/core/tvshow/domain/interfaces/i_online_repository.dart';
import 'package:tv_randshow/ui/shared/helpers/helpers.dart';

import '../../../../helpers/generate_tvshow.dart';
import 'get_random_episode_use_case_test.mocks.dart';

@GenerateMocks([IRandomService, IOnlineRepository])
void main() {
  final faker = Faker();
  final generateTvshow = GenerateTvshow();
  final onlineRepository = MockIOnlineRepository();
  final randomService = MockIRandomService();
  final String language = Helpers.getLocale();
  final useCase = GetRandomEpisodeUseCase(onlineRepository, randomService);

  setUp(() {
    reset(onlineRepository);
    reset(randomService);
  });
  group('should be a random episode when call use case -', () {
    test('number seasons more than 1', () async {
      final randomTvshow = generateTvshow.tvshowDetails;
      final randomSeason =
          faker.randomGenerator.integer(randomTvshow.numberOfSeasons, min: 1);
      final seasonsDetails = generateTvshow.tvshowSeasonsDetails
          .copyWith(seasonNumber: randomSeason);
      final randomEpisodeIndex =
          faker.randomGenerator.integer(seasonsDetails.episodes.length);
      final randomEpisode = seasonsDetails.episodes[randomEpisodeIndex];

      when(randomService.getNumber(max: randomTvshow.numberOfSeasons, min: 1))
          .thenAnswer((async) => randomSeason);
      when(randomService.getNumber(max: seasonsDetails.episodes.length))
          .thenAnswer((async) => randomEpisodeIndex);
      when(
        onlineRepository.getDetailsTvSeasons(
          language,
          randomTvshow.id,
          randomSeason,
        ),
      ).thenAnswer((_) async => seasonsDetails);

      final result = await useCase(
        idTv: randomTvshow.id,
        numberOfSeasons: randomTvshow.numberOfSeasons,
      );

      verify(
        onlineRepository.getDetailsTvSeasons(
          language,
          randomTvshow.id,
          randomSeason,
        ),
      ).called(1);
      verify(randomService.getNumber(max: randomTvshow.numberOfSeasons, min: 1))
          .called(1);
      verify(randomService.getNumber(max: seasonsDetails.episodes.length))
          .called(1);
      expect(result.randomSeason, randomEpisode.seasonNumber);
      expect(result.randomEpisode, randomEpisode.episodeNumber);
    });
    test('number seasons equal 1', () async {
      const season = 1;
      final randomTvshow =
          generateTvshow.tvshowDetails.copyWith(numberOfSeasons: season);
      final seasonsDetails =
          generateTvshow.tvshowSeasonsDetails.copyWith(seasonNumber: season);
      final randomEpisodeIndex =
          faker.randomGenerator.integer(seasonsDetails.episodes.length);
      final randomEpisode = seasonsDetails.episodes[randomEpisodeIndex];

      when(randomService.getNumber(max: seasonsDetails.episodes.length))
          .thenAnswer((async) => randomEpisodeIndex);
      when(
        onlineRepository.getDetailsTvSeasons(
          language,
          randomTvshow.id,
          season,
        ),
      ).thenAnswer((_) async => seasonsDetails);

      final result = await useCase(
        idTv: randomTvshow.id,
        numberOfSeasons: randomTvshow.numberOfSeasons,
      );

      verify(
        onlineRepository.getDetailsTvSeasons(
          language,
          randomTvshow.id,
          season,
        ),
      ).called(1);
      // Do not use result.
      // ignore: avoid-ignoring-return-values
      verifyNever(
        randomService.getNumber(max: randomTvshow.numberOfSeasons, min: 1),
      );
      verify(randomService.getNumber(max: seasonsDetails.episodes.length))
          .called(1);
      expect(result.randomSeason, randomEpisode.seasonNumber);
      expect(result.randomEpisode, randomEpisode.episodeNumber);
    });
  });
  group('should throw errors when fail - ', () {
    test('numberOfSeasons is lower or equal than 0', () {
      final randomTvshow = generateTvshow.tvshowDetails;
      final numberOfSeasons = faker.randomGenerator.integer(0, min: -999);

      expect(
        () => useCase(
          idTv: randomTvshow.id,
          numberOfSeasons: numberOfSeasons,
        ),
        throwsA(
          predicate(
            (e) => e is AppError && e.code == AppErrorCode.invalidSeasonNumber,
          ),
        ),
      );
      const numberOfSeasons0 = 0;

      expect(
        () => useCase(
          idTv: randomTvshow.id,
          numberOfSeasons: numberOfSeasons0,
        ),
        throwsA(
          predicate(
            (e) => e is AppError && e.code == AppErrorCode.invalidSeasonNumber,
          ),
        ),
      );
    });
    test('seasonNumber is lower or equal than 0', () {
      final randomTvshow = generateTvshow.tvshowDetails.copyWith(
        numberOfSeasons: faker.randomGenerator.integer(999, min: 1),
      );
      final randomSeason =
          faker.randomGenerator.integer(randomTvshow.numberOfSeasons, min: 1);

      final baseTshowSeasonsDetails = generateTvshow.tvshowSeasonsDetails;
      final seasonsDetails = baseTshowSeasonsDetails.copyWith(
        episodes: baseTshowSeasonsDetails.episodes
            .map((e) => e.copyWith(seasonNumber: 0))
            .toList(),
      );
      final episodeIndex =
          faker.randomGenerator.integer(seasonsDetails.episodes.length);

      when(randomService.getNumber(max: randomTvshow.numberOfSeasons, min: 1))
          .thenAnswer((async) => randomSeason);
      when(randomService.getNumber(max: seasonsDetails.episodes.length))
          .thenAnswer((async) => episodeIndex);
      when(
        onlineRepository.getDetailsTvSeasons(
          language,
          randomTvshow.id,
          randomSeason,
        ),
      ).thenAnswer((_) async => seasonsDetails);

      expect(
        () => useCase(
          idTv: randomTvshow.id,
          numberOfSeasons: randomTvshow.numberOfSeasons,
        ),
        throwsA(
          predicate(
            (e) => e is AppError && e.code == AppErrorCode.invalidSeasonNumber,
          ),
        ),
      );
    });
    test('episodeNumber is lower or equal than 0', () {
      final randomTvshow = generateTvshow.tvshowDetails.copyWith(
        numberOfSeasons: faker.randomGenerator.integer(999, min: 1),
      );
      final randomSeason =
          faker.randomGenerator.integer(randomTvshow.numberOfSeasons, min: 1);

      final baseTshowSeasonsDetails = generateTvshow.tvshowSeasonsDetails;
      final seasonsDetails = baseTshowSeasonsDetails.copyWith(
        episodes: baseTshowSeasonsDetails.episodes
            .map((e) => e.copyWith(episodeNumber: 0))
            .toList(),
      );
      final episodeIndex =
          faker.randomGenerator.integer(seasonsDetails.episodes.length);

      when(randomService.getNumber(max: randomTvshow.numberOfSeasons, min: 1))
          .thenAnswer((async) => randomSeason);
      when(randomService.getNumber(max: seasonsDetails.episodes.length))
          .thenAnswer((async) => episodeIndex);
      when(
        onlineRepository.getDetailsTvSeasons(
          language,
          randomTvshow.id,
          randomSeason,
        ),
      ).thenAnswer((_) async => seasonsDetails);

      expect(
        () => useCase(
          idTv: randomTvshow.id,
          numberOfSeasons: randomTvshow.numberOfSeasons,
        ),
        throwsA(
          predicate(
            (e) => e is AppError && e.code == AppErrorCode.invalidEpisodeNumber,
          ),
        ),
      );
    });
  });
}
