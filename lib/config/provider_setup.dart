import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../core/services/api_service.dart';
import '../core/services/connection_service.dart';
import '../core/services/database_service.dart';
import '../core/services/secure_storage_service.dart';

List<SingleChildWidget> getProviders() {
  final List<SingleChildWidget> independentServices = <SingleChildWidget>[
    Provider<ApiService>.value(value: ApiService()),
    Provider<DatabaseService>.value(value: DatabaseService()),
    Provider<SecureStorageService>.value(value: SecureStorageService()),
  ];

  final List<SingleChildWidget> dependentServices = <SingleChildWidget>[
    ProxyProvider3<ApiService, DatabaseService, SecureStorageService,
        ConnectionService>(
      update: (
        BuildContext context,
        ApiService apiService,
        DatabaseService databaseService,
        SecureStorageService secureStorageService,
        ConnectionService connectionService,
      ) =>
          ConnectionService(
        apiService: apiService,
        databaseService: databaseService,
        secureStorageService: secureStorageService,
      ),
    )
  ];

  final List<SingleChildWidget> uiConsumableProviders = <SingleChildWidget>[];

  return <SingleChildWidget>[
    ...independentServices,
    ...dependentServices,
    ...uiConsumableProviders
  ];
}
