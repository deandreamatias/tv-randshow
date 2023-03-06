import 'package:injectable/injectable.dart';
import 'package:tv_randshow/core/tvshow/domain/interfaces/i_database_repository.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_details.dart';

@Injectable()
class VerifyDatabaseUseCase {
  final IDatabaseRepository _databaseService;

  const VerifyDatabaseUseCase(this._databaseService);

  Future<bool> call() async {
    final List<TvshowDetails> tvshows = await _databaseService.getTvshows();
    return tvshows.isEmpty;
  }
}
