import 'package:injectable/injectable.dart';
import 'package:tv_randshow/common/services/shared_preferences_service.dart';

@lazySingleton
class LocalStorageService extends SharedPreferencesService {}
