import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_randshow/core/io/domain/interfaces/i_manage_files_service.dart';
import 'package:tv_randshow/core/io/domain/interfaces/i_permissions_service.dart';
import 'package:tv_randshow/core/io/domain/models/tvshows_file.dart';
import 'package:tv_randshow/core/io/domain/use_cases/export_tvshows_use_case.dart';
import 'package:tv_randshow/core/tvshow/domain/interfaces/i_local_repository.dart';

import '../../../../helpers/generate_tvshow.dart';
import 'export_tvshows_use_case_test.mocks.dart';

@GenerateMocks([ILocalRepository, IManageFilesService, IPermissionsService])
Future<void> main() async {
  final generateTvshow = GenerateTvshow();
  final databaseService = MockILocalRepository();
  final manageFiles = MockIManageFilesService();
  final permissions = MockIPermissionsService();
  final useCase = ExportTvShowsUseCase(
    databaseService,
    manageFiles,
    permissions,
  );

  setUpAll(() {
    reset(databaseService);
    reset(manageFiles);
    reset(permissions);
  });

  test('should save tv shows when call use case', () async {
    final tvshows = generateTvshow.tvshows;
    final nowDateTime = DateTime.now().toLocal().toIso8601String().split('.');
    final fileName = 'tvrandshow-${nowDateTime[0]}';
    final tvshowFile = TvshowsFile(tvshows: tvshows).toRawJson();
    when(databaseService.getTvshows()).thenAnswer((_) async => tvshows);
    when(permissions.getStoragePermission()).thenAnswer((_) async => true);
    when(
      manageFiles.saveFile(
        fileName,
        tvshowFile,
      ),
    ).thenAnswer((_) async => fileName);

    expect(await useCase(), isTrue);
  });
  test('should dont save tv shows when permission is denied', () async {
    final tvshows = generateTvshow.tvshows;
    final nowDateTime = DateTime.now().toLocal().toIso8601String().split('.');
    final fileName = 'tvrandshow-${nowDateTime[0]}';
    when(databaseService.getTvshows()).thenAnswer((_) async => tvshows);
    when(permissions.getStoragePermission()).thenAnswer((_) async => false);
    when(
      manageFiles.saveFile(
        fileName,
        TvshowsFile(tvshows: tvshows).toRawJson(),
      ),
    ).thenAnswer((_) async => fileName);

    expect(await useCase(), isFalse);
  });
  test('should dont save tv shows when database is empty', () async {
    final nowDateTime = DateTime.now().toLocal().toIso8601String().split('.');
    final fileName = 'tvrandshow-${nowDateTime[0]}';
    when(databaseService.getTvshows()).thenAnswer((_) async => []);
    when(permissions.getStoragePermission()).thenAnswer((_) async => true);
    when(manageFiles.saveFile(fileName, TvshowsFile(tvshows: []).toRawJson()))
        .thenAnswer((_) async => fileName);

    expect(await useCase(), isFalse);
  });
  test('should dont save tv shows when file name is empty', () async {
    final tvshows = generateTvshow.tvshows;
    final nowDateTime = DateTime.now().toLocal().toIso8601String().split('.');
    final fileName = 'tvrandshow-${nowDateTime[0]}';
    when(databaseService.getTvshows()).thenAnswer((_) async => tvshows);
    when(permissions.getStoragePermission()).thenAnswer((_) async => true);
    when(
      manageFiles.saveFile(
        fileName,
        TvshowsFile(tvshows: tvshows).toRawJson(),
      ),
    ).thenAnswer((_) async => '');

    expect(await useCase(), isFalse);
  });
}
