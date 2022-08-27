import 'package:tv_randshow/core/tvshow/domain/models/migration_status.dart';

class MigrationModel {
  final String error;
  final MigrationStatus status;

  MigrationModel({this.error = '', required this.status});
}
