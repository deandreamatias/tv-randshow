import 'dart:convert';

class TvshowActions {
  TvshowActions({this.tvshow});
  factory TvshowActions.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return TvshowActions(
      tvshow: map['tvshow'],
    );
  }
  factory TvshowActions.fromJson(String source) =>
      TvshowActions.fromMap(json.decode(source));

  String tvshow;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tvshow': tvshow,
    };
  }

  String toJson() => json.encode(toMap());
}
