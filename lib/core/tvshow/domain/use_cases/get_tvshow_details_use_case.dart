import 'package:injectable/injectable.dart';
import 'package:tv_randshow/core/models/query.dart';
import 'package:tv_randshow/core/models/tvshow_details.dart';
import 'package:tv_randshow/core/tvshow/domain/interfaces/i_tvshow_repository.dart';

@injectable
class GetTvshowDetailsUseCase {
  final ITvshowRepository _tvshowRepository;

  const GetTvshowDetailsUseCase(this._tvshowRepository);

  Future<TvshowDetails> call(Query query, int idTv) async {
    return _tvshowRepository.getDetailsTv(query, idTv);
  }
}
