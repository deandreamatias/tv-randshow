import 'package:injectable/injectable.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_details.dart';
import 'package:tv_randshow/core/tvshow/domain/use_cases/get_local_tvshows_use_case.dart';

@Injectable()
class VerifyDatabaseUseCase {
  final GetLocalTvshowsUseCase _getTvshows;

  const VerifyDatabaseUseCase(this._getTvshows);

  Future<bool> call() async {
    final List<TvshowDetails> tvshows = await _getTvshows();

    return tvshows.isEmpty;
  }
}
