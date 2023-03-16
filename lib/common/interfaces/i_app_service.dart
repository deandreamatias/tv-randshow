import 'package:tv_randshow/common/models/tvshow_actions.dart';

abstract class IAppService {
  Future<String> getVersion();
  Future<TvshowActions> initUniLinks();
}
