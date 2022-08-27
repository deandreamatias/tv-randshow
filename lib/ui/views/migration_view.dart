import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:tv_randshow/config/locator.dart';
import 'package:tv_randshow/core/tvshow/domain/models/migration_model.dart';
import 'package:tv_randshow/core/tvshow/domain/models/migration_status.dart';
import 'package:tv_randshow/core/tvshow/domain/use_cases/mobile_database_migration_use_case.dart';
import 'package:tv_randshow/core/utils/constants.dart';
import 'package:unicons/unicons.dart';

import 'tab_view.dart';

class MigrationView extends StatelessWidget {
  const MigrationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MobileDatabaseMigrationUseCase _migrationUseCase =
        locator<MobileDatabaseMigrationUseCase>();
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: StreamBuilder<MigrationModel>(
            stream: _migrationUseCase(),
            builder: (context, snapshot) {
              final order = snapshot.data?.status.getOrder() ?? 0;
              return Column(
                children: [
                  Text(
                    translate('app.migration.title'),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    translate('app.migration.subtitle'),
                    style: Theme.of(context).textTheme.subtitle2,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  if (snapshot.connectionState != ConnectionState.done)
                    CircularProgressIndicator(),
                  _Checkpoint(
                    label: 'app.migration.loaded_old',
                    checked: order >= MigrationStatus.loadedOld.getOrder(),
                  ),
                  if (order == MigrationStatus.emptyOld.getOrder()) ...[
                    const SizedBox(height: 8),
                    _Checkpoint(
                        label: 'app.migration.empty_old', checked: true),
                  ] else ...[
                    const SizedBox(height: 8),
                    _Checkpoint(
                      label: 'app.migration.saved_to_new',
                      checked: order >= MigrationStatus.savedToNew.getOrder(),
                    ),
                    const SizedBox(height: 8),
                    _Checkpoint(
                      label: 'app.migration.verify_data',
                      checked: order >= MigrationStatus.verifyData.getOrder(),
                    ),
                    const SizedBox(height: 8),
                    _Checkpoint(
                      label: 'app.migration.deleted_old',
                      checked: order >= MigrationStatus.deletedOld.getOrder(),
                    ),
                    const SizedBox(height: 8),
                  ],
                  if (snapshot.data?.error.isNotEmpty ?? false)
                    Text(
                        '${translate('app.migration.error')}:\n ${snapshot.data?.error}'),
                  const SizedBox(height: 8),
                  if (snapshot.hasError) Text(snapshot.error.toString()),
                  const SizedBox(height: 24),
                  OutlinedButton.icon(
                    label: Text(translate('app.migration.home_button')),
                    icon: const Icon(UniconsLine.home),
                    onPressed: () => Navigator.pushNamedAndRemoveUntil<TabView>(
                      context,
                      RoutePaths.TAB,
                      ModalRoute.withName(RoutePaths.TAB),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _Checkpoint extends StatelessWidget {
  final bool checked;
  final String label;
  const _Checkpoint({
    Key? key,
    this.checked = false,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(translate(label)),
        checked
            ? Icon(UniconsLine.check, color: Colors.green)
            : Icon(UniconsLine.times, color: Colors.red),
      ],
    );
  }
}
