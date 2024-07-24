import 'package:dartz/dartz.dart';
import 'package:films/core/error/failure.dart';
import 'package:films/feature/domain/entities/film_entity.dart';

abstract class FilmRepository {
  Future<Either<Failure, List<FilmEntity>>> getPopularFilms(int page);
  Future<Either<Failure, List<FilmEntity>>> searchFilms(String query);
}
