import 'package:flutter/material.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_details.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_result.dart';
import 'package:tv_randshow/ui/views/loading_view.dart';
import 'package:tv_randshow/ui/views/migration_view.dart';
import 'package:tv_randshow/ui/views/privacy_policy_view.dart';
import 'package:tv_randshow/ui/views/result_view.dart';
import 'package:tv_randshow/ui/views/splash_view.dart';
import 'package:tv_randshow/ui/views/tab_view.dart';

class RoutePaths {
  static const String migraiton = 'migration';
  static const String tab = '/tab';
  static const String privacy = 'privacy';
  static const String splash = '/';
  static const String loading = 'loading';
  static const String result = 'result';
}

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.splash:
        return MaterialPageRoute<SplashView>(
          builder: (_) => const SplashView(),
        );
      case RoutePaths.migraiton:
        return MaterialPageRoute<MigrationView>(
          builder: (_) => const MigrationView(),
        );
      case RoutePaths.tab:
        return MaterialPageRoute<TabView>(builder: (_) => const TabView());
      case RoutePaths.loading:
        return MaterialPageRoute<LoadingView>(
          builder: (_) =>
              LoadingView(tvshowDetails: settings.arguments as TvshowDetails),
        );
      case RoutePaths.result:
        return MaterialPageRoute<ResultView>(
          builder: (_) =>
              ResultView(tvshowResult: settings.arguments as TvshowResult),
        );
      case RoutePaths.privacy:
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
