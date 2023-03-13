import 'package:injectable/injectable.dart';

import 'package:tv_randshow/core/app/data/services/dio_service.dart';
import 'package:tv_randshow/core/app/domain/models/flavor_config.dart';
import 'package:tv_randshow/core/tvshow/data/helpers/tmdb_error_transformer.dart';

@lazySingleton
class TmdbHttpService extends DioService {
  TmdbHttpService()
      : super(
          FlavorConfig.instance.values.baseUrl,
          queryParams: {
            'api_key': FlavorConfig.instance.values.apiKey,
          },
          catchErrors: TmdbErrorTransformer.transformDioErros,
        );
}
