import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

// import 'core/models/user.dart';
// import 'core/services/api.dart';

class ProviderSetup {
  List<SingleChildWidget> getProviders() {}

  List<SingleChildWidget> providers = <SingleChildWidget>[
    ...independentServices,
    ...dependentServices,
    ...uiConsumableProviders
  ];

  static List<SingleChildWidget> independentServices = <SingleChildWidget>[
    // Provider.value(value: Api())
  ];

  static List<SingleChildWidget> dependentServices = <SingleChildWidget>[
    // ProxyProvider<Api, AuthenticationService>(
    //   builder: (context, api, authenticationService) =>
    //       AuthenticationService(api: api),
    // )
  ];

  static List<SingleChildWidget> uiConsumableProviders = <SingleChildWidget>[];
}
