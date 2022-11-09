import 'package:faker/faker.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:tv_randshow/core/models/season.dart';

import 'package:tv_randshow/core/models/tvshow_details.dart';
import 'package:tv_randshow/core/services/databases/i_secondary_database_service.dart';

@Environment("mobile")
@injectable
class VerifyOldDatabaseUseCase {
  final ISecondaryDatabaseService _secondaryDatabaseService;

  VerifyOldDatabaseUseCase(this._secondaryDatabaseService);

  /// Return if old database has data
  Future<bool> call() async {
    final List<TvshowDetails> tvshows =
        await _secondaryDatabaseService.getTvshows();
    if (kDebugMode && tvshows.isEmpty) {
      final faker = Faker();
      await _secondaryDatabaseService.saveTvshows(
        List.generate(
          10,
          (index) => TvshowDetails(
            episodeRunTime: faker.randomGenerator
                .numbers(1000, faker.randomGenerator.integer(999)),
            id: faker.randomGenerator.integer(9999),
            inProduction: faker.randomGenerator.boolean() ? 1 : 0,
            name: faker.lorem.sentence(),
            numberOfEpisodes: faker.randomGenerator.integer(999),
            numberOfSeasons: faker.randomGenerator.integer(50),
            overview: faker.lorem.sentence(),
            posterPath: faker.internet.uri('http'),
            rowId: faker.randomGenerator
                .integer(faker.randomGenerator.integer(999)),
            seasons: List.generate(faker.randomGenerator.integer(50),
                (index) => Season(id: faker.randomGenerator.integer(9999))),
          ),
        ),
      );
    }
    return tvshows.isNotEmpty;
  }
}
