import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tv_randshow/core/utils/constants.dart';
import 'package:tv_randshow/ui/states/migration_status_state.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  MigrationStatusState _migrationStatusState =
      MigrationStatusState(isWeb: kIsWeb);

  @override
  void initState() {
    _migrationStatusState.loadStatus().whenComplete(() {
      _migrationStatusState.completeMigration
          ? Navigator.of(context).pushNamed(RoutePaths.TAB)
          : Navigator.of(context).pushNamed(RoutePaths.MIGRATION);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
