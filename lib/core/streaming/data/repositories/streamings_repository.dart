import 'dart:developer';

import 'package:injectable/injectable.dart';

import '../../../app/data/services/http_service.dart';
import '../../domain/interfaces/i_streamings_repository.dart';
import '../../domain/models/streaming_search.dart';
import '../models/basic_streaming_search.dart';

@Injectable(as: IStreamingsRepository)
class StreamingsRepository implements IStreamingsRepository {
  final HttpService _httpService;
  StreamingsRepository(this._httpService);

  @override
  Future<void> searchTvShow(StreamingSearch streamingSearch) async {
    final String path = '/get/basic';
    final data = BasicStreamingSearch(
      country: streamingSearch.country,
      tmdbId: 'tv/${streamingSearch.tmdbId}',
    );
    final response = await _httpService.get(path, data.toJson());
    log(response.toString());
    log(response['streamingInfo'].toString());
  }
}
