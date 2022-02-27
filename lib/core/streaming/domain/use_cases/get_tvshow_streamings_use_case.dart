import 'package:injectable/injectable.dart';

import '../interfaces/i_streamings_repository.dart';
import '../models/streaming_search.dart';

@injectable
class GetTvshowStreamingsUseCase {
  final IStreamingsRepository _streamingsRepository;

  GetTvshowStreamingsUseCase(this._streamingsRepository);

  Future<void> call(StreamingSearch streamingSearch) async {
    await _streamingsRepository.searchTvShow(streamingSearch);
  }
}
