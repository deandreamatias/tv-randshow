import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../core/services/api_service.dart';
import '../core/services/database_service.dart';
import '../core/services/random_service.dart';

List<SingleChildWidget> getProviders() {
  final List<SingleChildWidget> independentServices = <SingleChildWidget>[
    Provider<ApiService>.value(value: ApiService()),
    Provider<DatabaseService>.value(value: DatabaseService()),
  ];

  final List<SingleChildWidget> dependentServices = <SingleChildWidget>[
    ProxyProvider<ApiService, RandomService>(
      update: (
        BuildContext context,
        ApiService apiService,
        RandomService randomService,
      ) =>
          RandomService(
        apiService: apiService,
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
