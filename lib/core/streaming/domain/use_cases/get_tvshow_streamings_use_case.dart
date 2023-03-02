import 'package:injectable/injectable.dart';
import 'package:tv_randshow/core/streaming/domain/interfaces/i_streamings_repository.dart';
import 'package:tv_randshow/core/streaming/domain/models/streaming.dart';
import 'package:tv_randshow/core/streaming/domain/models/streaming_search.dart';

@injectable
class GetTvshowStreamingsUseCase {
  final IStreamingsRepository _streamingsRepository;

  GetTvshowStreamingsUseCase(this._streamingsRepository);

  Future<List<StreamingDetail>> call(StreamingSearch streamingSearch) async {
    final tvshow = await _streamingsRepository.searchTvShow(streamingSearch);
    return tvshow.streamings;
  }
}
