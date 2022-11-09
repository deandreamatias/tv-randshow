import 'package:flutter/material.dart';
import 'package:tv_randshow/core/tvshow/domain/models/migration_status.dart';
import 'package:tv_randshow/core/utils/constants.dart';
import 'package:tv_randshow/ui/states/migration_state.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  MigrationState migrationState = MigrationState();

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 300)).then((value) {
      migrationState.migration == MigrationStatus.complete
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
