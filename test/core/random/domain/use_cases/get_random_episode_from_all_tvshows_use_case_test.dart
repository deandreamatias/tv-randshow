import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_randshow/core/app/domain/exceptions/app_error.dart';
import 'package:tv_randshow/core/random/domain/interfaces/i_random_service.dart';
import 'package:tv_randshow/core/random/domain/use_cases/get_random_episode_from_all_tvshows_use_case.dart';
import 'package:tv_randshow/core/random/domain/use_cases/get_random_episode_use_case.dart';
import 'package:tv_randshow/core/tvshow/domain/interfaces/i_local_repository.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_result.dart';

import '../../../../helpers/generate_tvshow.dart';
import 'get_random_episode_from_all_tvshows_use_case_test.mocks.dart';

@GenerateMocks([ILocalRepository, GetRandomEpisodeUseCase, IRandomService])
void main() {
  final faker = Faker();
  final generateTvshow = GenerateTvshow();
  final localRepository = MockILocalRepository();
  final getRandomEpisodeUseCase = MockGetRandomEpisodeUseCase();
  final randomService = MockIRandomService();
  final useCase = GetRandomEpisodeFromAllTvshowsUseCase(
    localRepository,
    getRandomEpisodeUseCase,
    randomService,
  );

  setUp(() {
    reset(localRepository);
    reset(getRandomEpisodeUseCase);
    reset(randomService);
  });
  test('should get random episode when has fav tvshows', () async {
    final tvshows = generateTvshow.tvshows;
    final randomIndex = faker.randomGenerator.integer(tvshows.length);
    final tvshowResult = TvshowResult(
      image: faker.image.loremPicsum(),
      randomSeason: tvshows[randomIndex].numberOfSeasons,
      randomEpisode: faker.randomGenerator.integer(999, min: 1),
      episodeName: faker.lorem.sentence(),
    );

    when(localRepository.getTvshows()).thenAnswer((_) async => tvshows);
    when(randomService.getNumber(max: tvshows.length))
        .thenAnswer((async) => randomIndex);
    when(
      getRandomEpisodeUseCase(idTv: tvshows[randomIndex].id),
    ).thenAnswer(
      (_) async => tvshowResult,
    );

    final result = await useCase();

    expect(result, tvshowResult);
  });
  test('should get app error when dont has fav tvshows', () {
    when(localRepository.getTvshows()).thenAnswer((_) async => []);

    expect(
      () => useCase(),
      throwsA(
        predicate((e) => e is AppError && e.code == AppErrorCode.emptyFavs),
      ),
    );
  });
}
