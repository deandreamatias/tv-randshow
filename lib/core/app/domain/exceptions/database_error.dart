class DatabaseError implements Exception {
  final String message;
  final DatabaseErrorCode code;

  const DatabaseError({
    this.message = '',
    required this.code,
  });

  @override
  String toString() {
    return '${code.toString()} - $message';
  }
}

enum DatabaseErrorCode {
  init,
  read,
  delete,
  unknown,
}
