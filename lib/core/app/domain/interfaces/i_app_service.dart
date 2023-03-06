import 'package:tv_randshow/core/app/domain/models/tvshow_actions.dart';

abstract class IAppService {
  Future<String> getVersion();
  Future<TvshowActions> initUniLinks();
}
