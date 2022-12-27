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
  MigrationState migrationState = MigrationState(isWeb: kIsWeb);

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
              final order = snapshot.data?.getOrder() ?? 0;
              final isLoading =
                  snapshot.connectionState != ConnectionState.done &&
                      !snapshot.hasError;
              if (order > 0) {
                migrationState.updateStatus(snapshot.requireData);
              }
              return Column(
                children: [
                  ...header(),
                  if (!kIsWeb)
                    _Checkpoint(
                      label: 'app.migration.loaded_old',
                      checked: order >= MigrationStatus.loadedOld.getOrder(),
                    ),
                  if (order <= MigrationStatus.empty.getOrder()) ...[
                    const SizedBox(height: 8),
                    _Checkpoint(
                        label: 'app.migration.empty',
                        checked: order >= MigrationStatus.empty.getOrder()),
                  ] else ...[
                    if (!kIsWeb) ...databaseMigration(order, isLoading),
                    ...streamMigration(order, isLoading),
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

  List<Widget> header() {
    return [
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
    ];
  }

  List<Widget> databaseMigration(int order, bool isLoading) {
    return [
      const SizedBox(height: 8),
      _Checkpoint(
        label: 'app.migration.saved_to_new',
        checked: order >= MigrationStatus.savedToNew.getOrder(),
        isLoading: isLoading,
      ),
      const SizedBox(height: 8),
      _Checkpoint(
        label: 'app.migration.verify_data',
        checked: order >= MigrationStatus.verifyData.getOrder(),
        isLoading: isLoading,
      ),
      const SizedBox(height: 8),
      _Checkpoint(
        label: 'app.migration.deleted_old',
        checked: order >= MigrationStatus.deletedOld.getOrder(),
        isLoading: isLoading,
      ),
      const SizedBox(height: 8),
      _Checkpoint(
        label: 'app.migration.complete_database',
        checked: order >= MigrationStatus.completeDatabase.getOrder(),
        isLoading: isLoading,
      ),
    ];
  }

  List<Widget> streamMigration(int order, bool isLoading) {
    return [
      const SizedBox(height: 8),
      _Checkpoint(
        label: 'app.migration.add_streaming',
        checked: order >= MigrationStatus.addStreaming.getOrder(),
        isLoading: isLoading,
      ),
      const SizedBox(height: 8),
      _Checkpoint(
        label: 'app.migration.complete',
        checked: order >= MigrationStatus.complete.getOrder(),
        isLoading: isLoading,
      ),
    ];
  }
}

class _Checkpoint extends StatelessWidget {
  final bool checked;
  final String label;
  final bool isLoading;
  const _Checkpoint({
    Key? key,
    this.checked = false,
    this.isLoading = false,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(translate(label)),
        const SizedBox(width: 4),
        isLoading
            ? SizedBox(
                width: 12,
                height: 12,
                child: CircularProgressIndicator(),
              )
            : checked
                ? Icon(UniconsLine.check, color: Colors.green)
                : Icon(UniconsLine.times, color: Colors.red),
      ],
    );
  }
}
