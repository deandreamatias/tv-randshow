import 'package:tv_randshow/core/services/api_service.dart';
import 'package:tv_randshow/core/services/database_service.dart';
import 'package:tv_randshow/core/services/secure_storage_service.dart';

import 'log_service.dart';

class ConnectionService {
  ConnectionService({
    ApiService apiService,
    DatabaseService databaseService,
    SecureStorageService secureStorageService,
  })  : _apiService = apiService,
        _databaseService = databaseService,
        _secureStorageService = secureStorageService;

  final ApiService _apiService;
  final DatabaseService _databaseService;
  final SecureStorageService _secureStorageService;
  final LogService _logger = LogService.instance;
}
