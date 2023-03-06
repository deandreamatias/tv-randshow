import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_randshow/core/migration/domain/use_cases/verify_old_database_use_case.dart';
import 'package:tv_randshow/core/tvshow/domain/interfaces/i_secondary_database_service.dart';

import '../../../../helpers/generate_tvshow.dart';
import 'verify_old_database_use_case_test.mocks.dart';

@GenerateMocks([ISecondaryDatabaseService])
void main() {
  final generateTvshow = GenerateTvshow();
  final secondaryDatabase = MockISecondaryDatabaseService();
  final usecase = VerifyOldDatabaseUseCase(secondaryDatabase);

  setUp(() {
    reset(secondaryDatabase);
  });
  test('should be false when tv shows is not empty', () async {
    when(secondaryDatabase.getTvshows())
        .thenAnswer((_) async => generateTvshow.tvshows);

    final result = await usecase();

    verify(secondaryDatabase.getTvshows()).called(1);
    expect(result, isFalse);
  });
  test('should be true when tv shows is empty', () async {
    when(secondaryDatabase.getTvshows()).thenAnswer((_) async => []);

    final result = await usecase();

    verify(secondaryDatabase.getTvshows()).called(1);
    expect(result, isTrue);
  });
}
