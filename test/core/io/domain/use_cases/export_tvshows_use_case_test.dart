import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_randshow/core/io/domain/interfaces/i_manage_files_service.dart';
import 'package:tv_randshow/core/io/domain/models/tvshows_file.dart';
import 'package:tv_randshow/core/io/domain/use_cases/export_tvshows_use_case.dart';
import 'package:tv_randshow/core/tvshow/domain/interfaces/i_local_repository.dart';

import '../../../../helpers/generate_tvshow.dart';
import 'export_tvshows_use_case_test.mocks.dart';

@GenerateMocks([ILocalRepository, IManageFilesService])
Future<void> main() async {
  final generateTvshow = GenerateTvshow();
  final localRepository = MockILocalRepository();
  final manageFiles = MockIManageFilesService();
  final useCase = ExportTvShowsUseCase(localRepository, manageFiles);

  setUpAll(() {
    reset(localRepository);
    reset(manageFiles);
  });

  test('should save tv shows when call use case', () async {
    final tvshows = generateTvshow.tvshows;
    final nowDateTime = DateTime.now().toLocal().toIso8601String().split('.');
    final fileName = 'tvrandshow-${nowDateTime.first}';
    final tvshowFile = TvshowsFile(tvshows: tvshows).toRawJson();
    when(localRepository.getTvshows()).thenAnswer((_) async => tvshows);
    when(
      manageFiles.saveFile(fileName, tvshowFile),
    ).thenAnswer((_) async => fileName);

    expect(await useCase(), isTrue);
  });
  test('should dont save tv shows when database is empty', () {
    final nowDateTime = DateTime.now().toLocal().toIso8601String().split('.');
    final fileName = 'tvrandshow-${nowDateTime.first}';
    when(localRepository.getTvshows()).thenAnswer((_) async => []);
    when(
      manageFiles.saveFile(fileName, TvshowsFile(tvshows: []).toRawJson()),
    ).thenAnswer((_) async => fileName);

    expect(() => useCase(), throwsException);
  });
  test('should dont save tv shows when file name is empty', () async {
    final tvshows = generateTvshow.tvshows;
    final nowDateTime = DateTime.now().toLocal().toIso8601String().split('.');
    final fileName = 'tvrandshow-${nowDateTime.first}';
    when(localRepository.getTvshows()).thenAnswer((_) async => tvshows);
    when(
      manageFiles.saveFile(fileName, TvshowsFile(tvshows: tvshows).toRawJson()),
    ).thenAnswer((_) async => '');

    expect(await useCase(), isFalse);
  });
}
