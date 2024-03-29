import 'package:injectable/injectable.dart';
import 'package:tv_randshow/core/app/domain/exceptions/api_error.dart';
import 'package:tv_randshow/core/streaming/data/models/basic_streaming_search.dart';
import 'package:tv_randshow/core/streaming/data/models/streaming_output.dart';
import 'package:tv_randshow/core/streaming/data/services/streaming_http_service.dart';
import 'package:tv_randshow/core/streaming/domain/interfaces/i_streamings_repository.dart';
import 'package:tv_randshow/core/streaming/domain/models/streaming.dart';
import 'package:tv_randshow/core/streaming/domain/models/streaming_search.dart';

@Injectable(as: IStreamingsRepository)
class StreamingsRepository implements IStreamingsRepository {
  final StreamingHttpService _httpService;
  StreamingsRepository(this._httpService);

  @override
  Future<List<StreamingDetail>> searchTvShow(
    StreamingSearch streamingSearch,
  ) async {
    const String path = '/get/basic';
    final data = BasicStreamingSearch(
      country: streamingSearch.country,
      tmdbIdOutput: 'tv/${streamingSearch.tmdbId}',
    );
    try {
      final response = await _httpService.get(path, query: data.toJson());

      return StreamingOutput.fromJson(response).streamings;
    } on ApiError catch (e) {
      if (e.code == ApiErrorCode.notFound) {
        return [];
      }
      rethrow;
    }
  }
}
