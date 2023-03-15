import 'package:flutter/material.dart';
import 'package:tv_randshow/ui/features/info/views/privacy_policy_view.dart';
import 'package:tv_randshow/ui/features/init/splash_view.dart';
import 'package:tv_randshow/ui/features/init/tab_view.dart';
import 'package:tv_randshow/ui/features/migration/migration_view.dart';
import 'package:tv_randshow/ui/features/random/loading_tvshow_view.dart';
import 'package:tv_randshow/ui/features/random/result_view.dart';

class Router {
  static Route generateRoute(RouteSettings settings) {
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
        return MaterialPageRoute<LoadingTvshowView>(
          builder: (_) => LoadingTvshowView(idTv: settings.arguments as int),
        );
      case RoutePaths.result:
        return MaterialPageRoute<ResultView>(
          builder: (_) => ResultView(idTv: settings.arguments as int),
        );
      case RoutePaths.privacy:
        return MaterialPageRoute<PrivacyPolicyView>(
          builder: (_) => const PrivacyPolicyView(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}

class RoutePaths {
  static const String migraiton = 'migration';
  static const String tab = '/tab';
  static const String privacy = 'privacy';
  static const String splash = '/';
  static const String loading = 'loading';
  static const String result = 'result';
}
