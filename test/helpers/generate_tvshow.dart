// ignore_for_file: avoid-ignoring-return-values, no-magic-number, no-equal-arguments, avoid-top-level-members-in-tests

import 'package:faker/faker.dart';
import 'package:tv_randshow/core/tvshow/domain/models/episode.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_details.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_seasons_details.dart';

class GenerateTvshow {
  final _faker = Faker();
  TvshowDetails get tvshowDetails => TvshowDetails(
    episodeRunTime: _faker.randomGenerator.numbers(
      1000,
      _faker.randomGenerator.integer(999),
    ),
    id: _faker.randomGenerator.integer(9999),
    inProduction: _faker.randomGenerator.boolean() ? 1 : 0,
    name: _faker.lorem.sentence(),
    numberOfEpisodes: _faker.randomGenerator.integer(999),
    numberOfSeasons: _faker.randomGenerator.integer(50, min: 1),
    overview: _faker.lorem.sentence(),
    posterPath: _faker.internet.httpsUrl(),
    rowId: _faker.randomGenerator.integer(_faker.randomGenerator.integer(999)),
  );

  Episode get episode => Episode(
    episodeNumber: _faker.randomGenerator.integer(50),
    name: _faker.lorem.sentence(),
    id: _faker.randomGenerator.integer(50),
    seasonNumber: _faker.randomGenerator.integer(50, min: 1),
  );

  List<TvshowDetails> get tvshows =>
      random.amount<TvshowDetails>((i) => tvshowDetails, 50);

  TvshowSeasonsDetails get tvshowSeasonsDetails => TvshowSeasonsDetails(
    seasonNumber: _faker.randomGenerator.integer(99, min: 1),
    episodes: random.amount<Episode>((i) => episode, 50),
    id: _faker.randomGenerator.integer(9999),
    name: _faker.lorem.sentence(),
    overview: _faker.lorem.sentence(),
    posterPath: _faker.internet.httpsUrl(),
  );
}
