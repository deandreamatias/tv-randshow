import 'package:injectable/injectable.dart';
import 'package:tv_randshow/core/tvshow/domain/interfaces/i_online_repository.dart';
import 'package:tv_randshow/core/tvshow/domain/models/query.dart';
import 'package:tv_randshow/core/tvshow/domain/models/search.dart';

@injectable
class SearchTvShowUseCase {
  final IOnlineRepository _onlineRepository;

  const SearchTvShowUseCase(this._onlineRepository);

  Future<Search> call(Query query) async {
    return _onlineRepository.search(query);
  }
}
