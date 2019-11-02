import 'dart:convert';

class TvshowSearch {
  int page;
  List<TvShowSearchItem> results;
  int totalResults;
  int totalPages;

  TvshowSearch({
    this.page,
    this.results,
    this.totalResults,
    this.totalPages,
  });

  factory TvshowSearch.fromRawJson(String str) => TvshowSearch.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TvshowSearch.fromJson(Map<String, dynamic> json) => TvshowSearch(
        page: json["page"],
        results:
            List<TvShowSearchItem>.from(json["results"].map((x) => TvShowSearchItem.fromJson(x))),
        totalResults: json["total_results"],
        totalPages: json["total_pages"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_results": totalResults,
        "total_pages": totalPages,
      };
}

class TvShowSearchItem {
  String posterPath;
  int id;
  String name;

  TvShowSearchItem({
    this.posterPath,
    this.id,
    this.name,
  });

  factory TvShowSearchItem.fromRawJson(String str) => TvShowSearchItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TvShowSearchItem.fromJson(Map<String, dynamic> json) => TvShowSearchItem(
        posterPath: json["poster_path"],
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "poster_path": posterPath,
        "id": id,
        "name": name,
      };
}
