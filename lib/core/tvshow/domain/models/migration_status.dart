enum MigrationStatus {
  init,
  emptyOld,
  loadedOld,
  savedToNew,
  verifyData,
  deletedOld,
  completeDatabase,
  addStreaming,
  complete,
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
      case MigrationStatus.completeDatabase:
        return 6;
      case MigrationStatus.addStreaming:
        return 7;
      case MigrationStatus.complete:
        return 8;
      case MigrationStatus.error:
        return -1;
      case MigrationStatus.init:
      default:
        return 0;
    }
  }
}

extension MigrationStatusIntExtenstion on int {
  MigrationStatus getStatus() {
    switch (this) {
      case 1:
        return MigrationStatus.loadedOld;
      case 2:
        return MigrationStatus.emptyOld;
      case 3:
        return MigrationStatus.savedToNew;
      case 4:
        return MigrationStatus.verifyData;
      case 5:
        return MigrationStatus.deletedOld;
      case 6:
        return MigrationStatus.completeDatabase;
      case 7:
        return MigrationStatus.addStreaming;
      case 8:
        return MigrationStatus.complete;
      case -1:
        return MigrationStatus.error;
      case 0:
      default:
        return MigrationStatus.init;
    }
  }
}
