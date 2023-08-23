class Movie {
  final String releaseDate;
 String title;
  final String posterPath;
  final String overview;
  final int votecount;
  final bool? isadded;
  final int? id;
  Movie(
      {required this.releaseDate,
      required this.title,
      required this.posterPath,
      required this.overview,
      required this.votecount,
      this.isadded,
      this.id});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        releaseDate: json['release_date'] ?? '',
        title: json['title'] ?? '',
        posterPath: json['poster_path'] ?? '',
        votecount: json['vote_count'] ?? "",
        overview: json['overview'] ?? "",
        isadded: false);
  }
  Map<String, dynamic> toMap() {
    return {
      'releaseDate': releaseDate,
      'title': title,
      'posterPath': posterPath,
      'overview': overview,
      'voteCount': votecount,
    };
  }
}
