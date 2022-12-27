import 'package:injectable/injectable.dart';

import 'package:tv_randshow/core/models/tvshow_details.dart';
import 'package:tv_randshow/core/services/databases/i_database_service.dart';

@Injectable()
class VerifyDatabaseUseCase {
  final IDatabaseService _databaseService;

  const VerifyDatabaseUseCase(this._databaseService);

  /// Return if actual database has data
  Future<bool> call() async {
    final List<TvshowDetails> tvshows = await _databaseService.getTvshows();
    return tvshows.isEmpty;
  }
}
