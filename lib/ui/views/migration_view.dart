import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:tv_randshow/core/tvshow/domain/models/migration_status.dart';
import 'package:tv_randshow/core/utils/constants.dart';
import 'package:tv_randshow/ui/states/migration_state.dart';
import 'package:unicons/unicons.dart';

class MigrationView extends StatefulWidget {
  const MigrationView({Key? key}) : super(key: key);

  @override
  State<MigrationView> createState() => _MigrationViewState();
}

class _MigrationViewState extends State<MigrationView> {
  MigrationState migrationState = MigrationState();

  @override
  void initState() {
    migrationState.initMigration();
    super.initState();
  }

  @override
  void dispose() {
    migrationState.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: StreamBuilder<MigrationStatus>(
            stream: migrationState.stream,
            builder: (context, snapshot) {
              final error = snapshot.error;
              final order = snapshot.data?.getOrder() ??
                  migrationState.migration.getOrder();
              if ((snapshot.data?.getOrder() ?? 0) > 0) {
                migrationState.saveStatus(snapshot.requireData);
              }
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
                  _Checkpoint(
                    label: 'app.migration.loaded_old',
                    checked: order >= MigrationStatus.loadedOld.getOrder(),
                  ),
                  if (order <= MigrationStatus.emptyOld.getOrder()) ...[
                    const SizedBox(height: 8),
                    _Checkpoint(
                        label: 'app.migration.empty_old',
                        checked: order >= MigrationStatus.emptyOld.getOrder()),
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
                    _Checkpoint(
                      label: 'app.migration.complete_database',
                      checked:
                          order >= MigrationStatus.completeDatabase.getOrder(),
                    ),
                  ],
                  if (snapshot.connectionState != ConnectionState.done &&
                      !snapshot.hasError) ...[
                    const SizedBox(height: 8),
                    CircularProgressIndicator(),
                    const SizedBox(height: 8),
                  ],
                  if (snapshot.hasError) ...[
                    Divider(thickness: 2),
                    Text('${translate('app.migration.error')}: ${error ?? ''}'),
                  ],
                  const SizedBox(height: 24),
                  OutlinedButton.icon(
                    label: Text(translate('app.migration.home_button')),
                    icon: const Icon(UniconsLine.home),
                    onPressed: () => Navigator.pushReplacementNamed(
                      context,
                      RoutePaths.TAB,
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