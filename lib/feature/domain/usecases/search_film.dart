import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:films/core/error/failure.dart';
import 'package:films/core/usecases/use_case.dart';
import 'package:films/feature/domain/entities/film_entity.dart';
import 'package:films/feature/domain/repositories/film_repository.dart';

class SearchFilm extends UseCase<List<FilmEntity>, SearchFilmParams> {
  final FilmRepository filmRepository;

  SearchFilm(this.filmRepository);

  @override
  Future<Either<Failure, List<FilmEntity>>> call(
      SearchFilmParams params) async {
    return await filmRepository.searchFilms(params.query);
  }
}

class SearchFilmParams extends Equatable {
  final String query;
  const SearchFilmParams({
    required this.query,
  });
  @override
  List<Object?> get props => [query];
}
