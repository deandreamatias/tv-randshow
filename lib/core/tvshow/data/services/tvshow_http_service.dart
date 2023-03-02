import 'package:injectable/injectable.dart';

import 'package:tv_randshow/common/services/dio_service.dart';
import 'package:tv_randshow/config/flavor_config.dart';

@lazySingleton
class TvshowHttpService extends DioService {
  TvshowHttpService()
      : super(
          FlavorConfig.instance.values.baseUrl,
          queryParams: {
            'api_key': FlavorConfig.instance.values.apiKey,
          },
        );
}
