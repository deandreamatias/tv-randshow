import 'package:injectable/injectable.dart';

import 'package:tv_randshow/common/services/dio_service.dart';
import 'package:tv_randshow/config/flavor_config.dart';

@lazySingleton
class HttpService extends DioService {
  HttpService()
      : super(
          FlavorConfig.instance.values.streamingBaseUrl,
          {
            'x-rapidapi-host': FlavorConfig.instance.values.streamingBaseUrl
                .substring(8), // Remove https://
            'x-rapidapi-key': FlavorConfig.instance.values.streamingApiKey,
          },
        );
}
