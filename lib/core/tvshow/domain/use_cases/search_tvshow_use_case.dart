import 'package:injectable/injectable.dart';
import 'package:tv_randshow/core/models/query.dart';
import 'package:tv_randshow/core/models/search.dart';
import 'package:tv_randshow/core/tvshow/domain/interfaces/i_tvshow_repository.dart';

@injectable
class SearchTvShowUseCase {
  final ITvshowRepository _tvshowRepository;

  const SearchTvShowUseCase(this._tvshowRepository);

  Future<Search> call(Query query) async {
    return _tvshowRepository.search(query);
  }
}
