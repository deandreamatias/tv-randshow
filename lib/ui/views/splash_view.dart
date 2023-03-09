import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tv_randshow/ui/router.dart';
import 'package:tv_randshow/ui/states/migration_status_state.dart';
import 'package:tv_randshow/ui/widgets/loader.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final MigrationStatusState _migrationStatusState =
      MigrationStatusState(isWeb: kIsWeb);

  @override
  void initState() {
    _migrationStatusState.loadStatus().whenComplete(() {
      _migrationStatusState.completeMigration
          ? Navigator.of(context).pushNamed(RoutePaths.tab)
          : Navigator.of(context).pushNamed(RoutePaths.migraiton);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: Loader()),
    );
  }
}
