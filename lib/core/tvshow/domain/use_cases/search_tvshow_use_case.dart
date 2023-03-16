import 'package:injectable/injectable.dart';
import 'package:tv_randshow/core/app/data/models/pagination_data_model.dart';
import 'package:tv_randshow/core/tvshow/domain/interfaces/i_online_repository.dart';
import 'package:tv_randshow/core/tvshow/domain/models/result.dart';
import 'package:tv_randshow/ui/shared/helpers/helpers.dart';

@injectable
class SearchTvShowUseCase {
  final IOnlineRepository _onlineRepository;

  const SearchTvShowUseCase(this._onlineRepository);

  Future<PaginationDataModel<Result>> call({
    required String text,
    int page = 1,
  }) {
    return _onlineRepository.search(
      language: Helpers.getLocale(),
      page: page,
      text: text,
    );
  }
}
