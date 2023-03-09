import 'package:injectable/injectable.dart';
import 'package:tv_randshow/core/tvshow/domain/interfaces/i_online_repository.dart';
import 'package:tv_randshow/core/tvshow/domain/models/search.dart';
import 'package:tv_randshow/ui/shared/helpers/helpers.dart';

@injectable
class SearchTvShowUseCase {
  final IOnlineRepository _onlineRepository;

  const SearchTvShowUseCase(this._onlineRepository);

  Future<Search> call({
    required String text,
    int page = 1,
  }) async {
    return _onlineRepository.search(
      language: Helpers.getLocale(),
      page: page,
      text: text,
    );
  }
}
