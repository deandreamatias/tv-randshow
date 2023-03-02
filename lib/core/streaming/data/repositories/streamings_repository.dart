import 'package:injectable/injectable.dart';
import 'package:tv_randshow/core/app/data/services/http_service.dart';
import 'package:tv_randshow/core/streaming/data/models/basic_streaming_search.dart';
import 'package:tv_randshow/core/streaming/data/models/streaming_output.dart';
import 'package:tv_randshow/core/streaming/domain/interfaces/i_streamings_repository.dart';
import 'package:tv_randshow/core/streaming/domain/models/streaming.dart';
import 'package:tv_randshow/core/streaming/domain/models/streaming_search.dart';

@Injectable(as: IStreamingsRepository)
class StreamingsRepository implements IStreamingsRepository {
  final HttpService _httpService;
  StreamingsRepository(this._httpService);

  @override
  Future<Streaming> searchTvShow(StreamingSearch streamingSearch) async {
    const String path = '/get/basic';
    final data = BasicStreamingSearch(
      country: streamingSearch.country,
      tmdbIdOutput: 'tv/${streamingSearch.tmdbId}',
    );
    final response = await _httpService.get(path, data.toJson());
    return StreamingOutput.fromJson(response);
  }
}
