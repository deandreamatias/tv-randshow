import 'package:injectable/injectable.dart';
import 'package:tv_randshow/common/services/dio_service.dart';
import 'package:tv_randshow/core/app/domain/models/flavor_config.dart';

@lazySingleton
class StreamingHttpService extends DioService {
  StreamingHttpService()
      : super(
          FlavorConfig.instance.values.streamingBaseUrl,
          headers: {
            'x-rapidapi-host': FlavorConfig.instance.values.streamingBaseUrl
                .substring(8), // Remove https://
            'x-rapidapi-key': FlavorConfig.instance.values.streamingApiKey,
          },
        );
}
