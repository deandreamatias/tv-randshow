import 'package:injectable/injectable.dart';
import 'package:tv_randshow/core/tvshow/domain/interfaces/i_secondary_local_repository.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_details.dart';

@Injectable(env: ['mobile'])
class VerifyOldDatabaseUseCase {
  final ISecondaryLocalRepository _secondaryDatabaseService;

  VerifyOldDatabaseUseCase(this._secondaryDatabaseService);

  Future<bool> call() async {
    final List<TvshowDetails> tvshows =
        await _secondaryDatabaseService.getTvshows();

    return tvshows.isEmpty;
  }
}
