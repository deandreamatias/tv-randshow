import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_randshow/core/migration/domain/use_cases/verify_database_use_case.dart';
import 'package:tv_randshow/core/tvshow/domain/use_cases/get_local_tvshows_use_case.dart';

import '../../../../helpers/generate_tvshow.dart';
import 'verify_database_use_case_test.mocks.dart';

@GenerateMocks([GetLocalTvshowsUseCase])
void main() {
  final generateTvshow = GenerateTvshow();
  final getLocalTvshows = MockGetLocalTvshowsUseCase();
  final usecase = VerifyDatabaseUseCase(getLocalTvshows);

  setUp(() {
    reset(getLocalTvshows);
  });
  test('should be false when tv shows is not empty', () async {
    when(getLocalTvshows()).thenAnswer((_) async => generateTvshow.tvshows);

    final result = await usecase();

    verify(getLocalTvshows()).called(1);
    expect(result, isFalse);
  });
  test('should be true when tv shows is empty', () async {
    when(getLocalTvshows()).thenAnswer((_) async => []);

    final result = await usecase();

    verify(getLocalTvshows()).called(1);
    expect(result, isTrue);
  });
}
