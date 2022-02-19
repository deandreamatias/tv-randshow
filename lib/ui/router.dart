import 'package:flutter/material.dart';

import '../core/models/tvshow_details.dart';
import '../core/models/tvshow_result.dart';
import '../core/utils/constants.dart';
import 'views/loading_view.dart';
import 'views/privacy_policy_view.dart';
import 'views/result_view.dart';
import 'views/tab_view.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.TAB:
        return MaterialPageRoute<TabView>(builder: (_) => const TabView());
      case RoutePaths.LOADING:
        return MaterialPageRoute<LoadingView>(
          builder: (_) =>
              LoadingView(tvshowDetails: settings.arguments as TvshowDetails),
        );
      case RoutePaths.RESULT:
        return MaterialPageRoute<ResultView>(
          builder: (_) =>
              ResultView(tvshowResult: settings.arguments as TvshowResult),
        );
      case RoutePaths.PRIVACY:
        return MaterialPageRoute<PrivacyPolicyView>(
          builder: (_) => const PrivacyPolicyView(),
        );
      default:
        return MaterialPageRoute<dynamic>(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
