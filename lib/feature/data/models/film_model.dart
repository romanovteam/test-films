import 'package:films/feature/domain/entities/film_entity.dart';

class FilmModel extends FilmEntity {
  const FilmModel({
    required super.id,
    required super.originalLanguage,
    required super.originalTitle,
    required super.overview,
    required super.popularity,
    required String? posterPath,
    required super.releaseDate,
    required super.title,
    required super.video,
    required super.voteAverage,
    required super.voteCount,
  }) : super(
          posterPath: posterPath ?? '',
        );

  factory FilmModel.fromJson(Map<String, dynamic> json) {
    return FilmModel(
      id: json['id'] ?? 0,
      originalLanguage: json['original_language'] ?? 'unknown',
      originalTitle: json['original_title'] ?? 'unknown',
      overview: json['overview'] ?? 'No overview available',
      popularity: (json['popularity'] as num).toDouble(),
      posterPath: json['poster_path'],
      releaseDate: json['release_date'] ?? 'unknown',
      title: json['title'] ?? 'unknown',
      video: json['video'] ?? false,
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'original_language': originalLanguage,
      'original_title': originalTitle,
      'overview': overview,
      'popularity': popularity,
      'poster_path': posterPath,
      'release_date': releaseDate,
      'title': title,
      'video': video,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }
}
