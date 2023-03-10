// ignore_for_file: avoid-ignoring-return-values, no-magic-number, no-equal-arguments, avoid-top-level-members-in-tests

import 'package:faker/faker.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_details.dart';

class GenerateTvshow {
  final _faker = Faker();
  TvshowDetails get tvshowDetails => TvshowDetails(
        episodeRunTime: _faker.randomGenerator
            .numbers(1000, _faker.randomGenerator.integer(999)),
        id: _faker.randomGenerator.integer(9999),
        inProduction: _faker.randomGenerator.boolean() ? 1 : 0,
        name: _faker.lorem.sentence(),
        numberOfEpisodes: _faker.randomGenerator.integer(999),
        numberOfSeasons: _faker.randomGenerator.integer(50),
        overview: _faker.lorem.sentence(),
        posterPath: _faker.internet.httpsUrl(),
        rowId:
            _faker.randomGenerator.integer(_faker.randomGenerator.integer(999)),
      );

  List<TvshowDetails> get tvshows =>
      random.amount<TvshowDetails>((i) => tvshowDetails, 50);
}
