import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:tv_randshow/core/migration/domain/models/migration_status.dart';
import 'package:tv_randshow/ui/features/migration/migration_state.dart';
import 'package:tv_randshow/ui/router.dart';
import 'package:tv_randshow/ui/shared/styles.dart';
import 'package:tv_randshow/ui/widgets/error_message.dart';
import 'package:tv_randshow/ui/widgets/loaders/loader.dart';
import 'package:unicons/unicons.dart';

class MigrationView extends StatefulWidget {
  const MigrationView({super.key});

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
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Styles.standard),
          child: StreamBuilder<MigrationStatus>(
            stream: migrationState.stream,
            builder: (context, snapshot) {
              final order = snapshot.data?.getOrder() ?? 0;
              final isLoading =
                  snapshot.connectionState != ConnectionState.done &&
                      !snapshot.hasError;
              if (order > 0) {
                migrationState.updateStatus(snapshot.requireData);
              }

              return Column(
                children: [
                  const _Header(),
                  if (!kIsWeb)
                    _Checkpoint(
                      label: 'app.migration.loaded_old',
                      checked: order >= MigrationStatus.loadedOld.getOrder(),
                    ),
                  if (order <= MigrationStatus.empty.getOrder()) ...[
                    const SizedBox(height: Styles.small),
                    _Checkpoint(
                      label: 'app.migration.empty',
                      checked: order >= MigrationStatus.empty.getOrder(),
                    ),
                  ] else ...[
                    if (!kIsWeb)
                      _DatabaseMigration(order: order, isLoading: isLoading),
                    _StreamMigration(order: order, isLoading: isLoading),
                  ],
                  if (snapshot.hasError) ...[
                    const Divider(thickness: 2),
                    ErrorMessage(
                      error: snapshot.error ?? Object(),
                      keyText: 'app.migration.error',
                    ),
                  ],
                  const SizedBox(height: Styles.large),
                  OutlinedButton.icon(
                    label: Text(translate('app.migration.home_button')),
                    icon: const Icon(UniconsLine.home),
                    onPressed: () => Navigator.pushReplacementNamed(
                      context,
                      RoutePaths.tab,
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

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          translate('app.migration.title'),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: Styles.small),
        Text(
          translate('app.migration.subtitle'),
          style: Theme.of(context).textTheme.titleSmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: Styles.standard),
      ],
    );
  }
}

class _DatabaseMigration extends StatelessWidget {
  final int order;
  final bool isLoading;
  const _DatabaseMigration({
    required this.order,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: Styles.small),
        _Checkpoint(
          label: 'app.migration.saved_to_new',
          checked: order >= MigrationStatus.savedToNew.getOrder(),
          isLoading: isLoading,
        ),
        const SizedBox(height: Styles.small),
        _Checkpoint(
          label: 'app.migration.verify_data',
          checked: order >= MigrationStatus.verifyData.getOrder(),
          isLoading: isLoading,
        ),
        const SizedBox(height: Styles.small),
        _Checkpoint(
          label: 'app.migration.deleted_old',
          checked: order >= MigrationStatus.deletedOld.getOrder(),
          isLoading: isLoading,
        ),
        const SizedBox(height: Styles.small),
        _Checkpoint(
          label: 'app.migration.complete_database',
          checked: order >= MigrationStatus.completeDatabase.getOrder(),
          isLoading: isLoading,
        ),
      ],
    );
  }
}

class _StreamMigration extends StatelessWidget {
  final int order;
  final bool isLoading;
  const _StreamMigration({
    required this.order,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: Styles.small),
        _Checkpoint(
          label: 'app.migration.add_streaming',
          checked: order >= MigrationStatus.addStreaming.getOrder(),
          isLoading: isLoading,
        ),
        const SizedBox(height: Styles.small),
        _Checkpoint(
          label: 'app.migration.complete',
          checked: order >= MigrationStatus.complete.getOrder(),
          isLoading: isLoading,
        ),
      ],
    );
  }
}

class _Checkpoint extends StatelessWidget {
  final bool checked;
  final String label;
  final bool isLoading;
  const _Checkpoint({
    this.checked = false,
    this.isLoading = false,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(translate(label)),
        const SizedBox(height: Styles.xsmall),
        isLoading
            ? const SizedBox.square(
                dimension: Styles.medium,
                child: Loader(),
              )
            : checked
                ? const Icon(UniconsLine.check, color: Colors.green)
                : const Icon(UniconsLine.times, color: Colors.red),
      ],
    );
  }
}
