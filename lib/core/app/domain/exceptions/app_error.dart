class AppError implements Exception {
  final String message;
  final AppErrorCode code;

  const AppError({
    this.message = '',
    required this.code,
  });

  @override
  String toString() {
    return '${code.toString()} - $message';
  }
}

enum AppErrorCode {
  emptyFavs,
  invalidSeasonNumber,
  invalidEpisodeNumber,
}
