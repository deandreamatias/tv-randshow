import 'package:tv_randshow/core/streaming/domain/models/streaming.dart';
import 'package:tv_randshow/core/streaming/domain/models/streaming_search.dart';

abstract class IStreamingsRepository {
  Future<Streaming> searchTvShow(StreamingSearch streamingSearch);
}
