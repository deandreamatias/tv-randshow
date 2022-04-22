class Streaming {
  Streaming({
    this.imdbId = '',
    this.tmdbId = '',
    required this.imdbRating,
    required this.imdbVoteCount,
    required this.tmdbRating,
    this.backdropPath = '',
    this.backdropUrLs,
    this.originalTitle = '',
    this.genres = const [],
    this.countries = const [],
    required this.year,
    required this.firstAirYear,
    required this.lastAirYear,
    this.episodeRuntimes = const [],
    this.cast = const [],
    this.significants = const [],
    this.title = '',
    this.overview = '',
    this.video = '',
    this.posterPath = '',
    this.posterUrLs,
    required this.seasons,
    required this.episodes,
    required this.age,
    required this.status,
    this.tagline = '',
    this.streamings = const [],
    this.originalLanguage = '',
  });

  final String imdbId;
  final String tmdbId;
  final int imdbRating;
  final int imdbVoteCount;
  final int tmdbRating;
  final String backdropPath;
  final BackdropUrLs? backdropUrLs;
  final String originalTitle;
  final List<int> genres;
  final List<String> countries;
  final int year;
  final int firstAirYear;
  final int lastAirYear;
  final List<int> episodeRuntimes;
  final List<String> cast;
  final List<String> significants;
  final String title;
  final String overview;
  final String video;
  final String posterPath;
  final PosterUrLs? posterUrLs;
  final int seasons;
  final int episodes;
  final int age;
  final int status;
  final String tagline;
  final List<StreamingDetail> streamings;
  final String originalLanguage;
}

class BackdropUrLs {
  BackdropUrLs({
    this.the300 = '',
    this.the780 = '',
    this.the1280 = '',
    this.original = '',
  });

  final String the300;
  final String the780;
  final String the1280;
  final String original;
}

class PosterUrLs {
  PosterUrLs({
    this.the92 = '',
    this.the154 = '',
    this.the185 = '',
    this.the342 = '',
    this.the500 = '',
    this.the780 = '',
    this.original = '',
  });

  final String the92;
  final String the154;
  final String the185;
  final String the342;
  final String the500;
  final String the780;
  final String original;
}

class StreamingDetail {
  StreamingDetail({
    required this.streamingName,
    this.link = '',
    required this.added,
    required this.leaving,
    required this.country,
  });

  final String streamingName;
  final String country;
  final String link;
  final int added;
  final int leaving;
}
