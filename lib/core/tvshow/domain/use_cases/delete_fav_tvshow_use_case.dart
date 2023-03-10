import 'package:injectable/injectable.dart';
import 'package:tv_randshow/core/tvshow/domain/interfaces/i_local_repository.dart';

@injectable
class DeleteFavTvshowUseCase {
  final ILocalRepository _localRepository;

  const DeleteFavTvshowUseCase(this._localRepository);

  Future<void> call(int id) {
    return _localRepository.deleteTvshow(id);
  }
}
