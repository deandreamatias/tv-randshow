import 'package:tv_randshow/core/streaming/domain/models/streaming_search.dart';

abstract class IStreamingsRepository {
  Future<void> searchTvShow(StreamingSearch streamingSearch);
}
