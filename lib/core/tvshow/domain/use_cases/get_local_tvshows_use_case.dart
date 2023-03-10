import 'package:injectable/injectable.dart';
import 'package:tv_randshow/core/tvshow/domain/interfaces/i_local_repository.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_details.dart';

@injectable
class GetLocalTvshowsUseCase {
  final ILocalRepository _localRepository;

  const GetLocalTvshowsUseCase(this._localRepository);

  Future<List<TvshowDetails>> call() {
    return _localRepository.getTvshows();
  }
}
