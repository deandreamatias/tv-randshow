import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../core/services/api_service.dart';
import '../core/services/database_service.dart';
import '../core/services/secure_storage_service.dart';

List<SingleChildWidget> getProviders() {
  final List<SingleChildWidget> independentServices = <SingleChildWidget>[
    Provider<ApiService>.value(value: ApiService()),
    Provider<DatabaseService>.value(value: DatabaseService()),
    Provider<SecureStorageService>.value(value: SecureStorageService()),
  ];

  final List<SingleChildWidget> dependentServices = <SingleChildWidget>[];

  final List<SingleChildWidget> uiConsumableProviders = <SingleChildWidget>[];

  return <SingleChildWidget>[
    ...independentServices,
    ...dependentServices,
    ...uiConsumableProviders
  ];
}
