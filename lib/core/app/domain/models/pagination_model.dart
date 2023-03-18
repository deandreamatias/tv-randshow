class PaginationModel<T> {
  int? page;
  List<T> results;
  int totalResults;
  int totalPages;

  PaginationModel({
    this.page,
    this.results = const [],
    this.totalResults = 0,
    this.totalPages = 0,
  });
}
