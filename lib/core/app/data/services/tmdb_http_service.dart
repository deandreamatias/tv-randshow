import 'package:injectable/injectable.dart';
import 'package:tv_randshow/common/models/flavor_config.dart';
import 'package:tv_randshow/common/services/dio_service.dart';
import 'package:tv_randshow/core/app/data/transformers/tmdb_error_transformer.dart';

@lazySingleton
class TmdbHttpService extends DioService {
  TmdbHttpService()
    : super(
        FlavorConfig.instance.values.baseUrl,
        queryParams: {'api_key': FlavorConfig.instance.values.apiKey},
        catchErrors: TmdbErrorTransformer.transformDioErros,
      );
}
