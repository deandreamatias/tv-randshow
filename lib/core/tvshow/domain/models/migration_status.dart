enum MigrationStatus {
  emptyOld,
  loadedOld,
  savedToNew,
  verifyData,
  deletedOld,
  error,
}

extension MigrationStatusExtenstion on MigrationStatus {
  int getOrder() {
    switch (this) {
      case MigrationStatus.loadedOld:
        return 1;
      case MigrationStatus.emptyOld:
        return 2;
      case MigrationStatus.savedToNew:
        return 3;
      case MigrationStatus.verifyData:
        return 4;
      case MigrationStatus.deletedOld:
        return 5;
      case MigrationStatus.error:
        return -1;
      default:
        return 0;
    }
  }
}
