import 'package:tv_randshow/core/app/data/models/pagination_data_model.dart';
import 'package:tv_randshow/core/trending/domain/models/media_type_enum.dart';
import 'package:tv_randshow/core/trending/domain/models/time_window_enum.dart';
import 'package:tv_randshow/core/trending/domain/models/trending_result.dart';

abstract class ITrendingRepository {
  Future<PaginationDataModel<TrendingResult>> getTrending({
    required MediaTypeEnum mediaType,
    required TimeWindowEnum timeWindow,
    required String language,
    int page = 1,
  });
}
