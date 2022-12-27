import 'package:injectable/injectable.dart';

import 'package:tv_randshow/core/models/tvshow_details.dart';
import 'package:tv_randshow/core/services/databases/i_secondary_database_service.dart';

@Injectable(env: ['mobile'])
class VerifyOldDatabaseUseCase {
  final ISecondaryDatabaseService _secondaryDatabaseService;

  VerifyOldDatabaseUseCase(this._secondaryDatabaseService);

  /// Return if old database has data
  Future<bool> call() async {
    final List<TvshowDetails> tvshows =
        await _secondaryDatabaseService.getTvshows();
    return tvshows.isNotEmpty;
  }
}
