import 'package:flutter/material.dart';
import 'package:tv_randshow/ui/features/info/views/privacy_policy_view.dart';
import 'package:tv_randshow/ui/features/init/splash_view.dart';
import 'package:tv_randshow/ui/features/init/tab_view.dart';
import 'package:tv_randshow/ui/features/migration/migration_view.dart';
import 'package:tv_randshow/ui/features/random/views/loading_trending_tvshow_view.dart';
import 'package:tv_randshow/ui/features/random/views/loading_tvshow_view.dart';
import 'package:tv_randshow/ui/features/random/views/loading_tvshows_view.dart';
import 'package:tv_randshow/ui/features/random/views/result_trending_tvshow_view.dart';
import 'package:tv_randshow/ui/features/random/views/result_tvshow_view.dart';
import 'package:tv_randshow/ui/features/random/views/result_tvshows_view.dart';

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
      case RoutePaths.loadingTvshow:
        return MaterialPageRoute<LoadingTvshowView>(
          builder: (_) => LoadingTvshowView(idTv: settings.arguments as int),
        );
      case RoutePaths.resultTvshow:
        return MaterialPageRoute<ResultTvshowView>(
          builder: (_) => ResultTvshowView(idTv: settings.arguments as int),
        );
      case RoutePaths.loadingTvshows:
        return MaterialPageRoute<LoadingTvshowsView>(
          builder: (_) => const LoadingTvshowsView(),
        );
      case RoutePaths.resultTvshows:
        return MaterialPageRoute<ResultTvshowsView>(
          builder: (_) => const ResultTvshowsView(),
        );
      case RoutePaths.loadingTrendingTvshow:
        return MaterialPageRoute<LoadingTrendingTvshowView>(
          builder: (_) => const LoadingTrendingTvshowView(),
        );
      case RoutePaths.resultTrendingTvshow:
        return MaterialPageRoute<ResultTrendingTvshowView>(
          builder: (_) => const ResultTrendingTvshowView(),
        );
      case RoutePaths.privacy:
        return MaterialPageRoute<PrivacyPolicyView>(
          builder: (_) => const PrivacyPolicyView(),
        );
      default:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(
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
  static const String loadingTvshow = 'loading-tvshow';
  static const String resultTvshow = 'result-tvshow';
  static const String loadingTvshows = 'loading-tvshows';
  static const String resultTvshows = 'result-tvshows';
  static const String loadingTrendingTvshow = 'loading-trending-tvshow';
  static const String resultTrendingTvshow = 'result-trending-tvshow';
}
