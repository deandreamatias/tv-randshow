import 'dart:convert';

class TvshowActions {
  String tvshow;
  TvshowActions({required this.tvshow});
  factory TvshowActions.fromMap(Map<String, dynamic> map) {
    return TvshowActions(
      tvshow: map['tvshow'],
    );
  }
  factory TvshowActions.fromJson(String source) =>
      TvshowActions.fromMap(json.decode(source));

  Map<String, dynamic> toMap() => {'tvshow': tvshow};

  String toJson() => json.encode(toMap());
}
