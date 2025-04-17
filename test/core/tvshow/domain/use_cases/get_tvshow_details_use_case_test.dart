// ignore_for_file: avoid-ignoring-return-values

import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_randshow/core/tvshow/domain/interfaces/i_online_repository.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_details.dart';
import 'package:tv_randshow/core/tvshow/domain/use_cases/get_local_tvshows_use_case.dart';
import 'package:tv_randshow/core/tvshow/domain/use_cases/get_tvshow_details_use_case.dart';
import 'package:tv_randshow/ui/shared/helpers/helpers.dart';

import '../../../../helpers/generate_tvshow.dart';
import 'get_tvshow_details_use_case_test.mocks.dart';

@GenerateMocks([GetLocalTvshowsUseCase, IOnlineRepository])
void main() {
  final faker = Faker();
  final generateTvshow = GenerateTvshow();
  final getLocalTvshow = MockGetLocalTvshowsUseCase();
  final onlineRepository = MockIOnlineRepository();
  final useCase = GetTvshowDetailsUseCase(onlineRepository, getLocalTvshow);

  setUp(() {
    reset(onlineRepository);
    reset(getLocalTvshow);
  });

  group('get online tvshow', () {
    test(
      'should return online tvshow when local tvshow list is empty',
      () async {
        final tvshows = generateTvshow.tvshows;
        final randomTvshow = faker.randomGenerator.element<TvshowDetails>(
          tvshows,
        );
        final String language = Helpers.getLocale();

        when(getLocalTvshow()).thenAnswer((_) async => []);
        when(
          onlineRepository.getDetailsTv(language, randomTvshow.id),
        ).thenAnswer((_) async => randomTvshow);

        final tvshow = await useCase(randomTvshow.id);

        verify(getLocalTvshow()).called(1);
        verify(
          onlineRepository.getDetailsTv(language, randomTvshow.id),
        ).called(1);
        expect(tvshow.id, randomTvshow.id);
      },
    );
    test(
      'should return online tvshow when local tvshow id do not exist',
      () async {
        final tvshows = generateTvshow.tvshows;
        final randomTvshow = faker.randomGenerator.element<TvshowDetails>(
          tvshows,
        );
        final localTvshows =
            tvshows.where((element) => element.id != randomTvshow.id).toList();
        final String language = Helpers.getLocale();

        when(getLocalTvshow()).thenAnswer((_) async => localTvshows);
        when(
          onlineRepository.getDetailsTv(language, randomTvshow.id),
        ).thenAnswer((_) async => randomTvshow);

        final tvshow = await useCase(randomTvshow.id);

        verify(getLocalTvshow()).called(1);
        verify(
          onlineRepository.getDetailsTv(language, randomTvshow.id),
        ).called(1);
        expect(tvshow.id, randomTvshow.id);
      },
    );
  });
  group('get local tvshow', () {
    test('should return local tvshow when exists', () async {
      final tvshows = generateTvshow.tvshows;
      final tvshowId = faker.randomGenerator.element<TvshowDetails>(tvshows).id;
      final String language = Helpers.getLocale();
      when(getLocalTvshow()).thenAnswer((_) async => tvshows);

      final tvshow = await useCase(tvshowId);

      verify(getLocalTvshow()).called(1);
      verifyNever(onlineRepository.getDetailsTv(language, tvshowId));
      expect(tvshow.id, tvshowId);
    });
  });
}
