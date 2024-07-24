import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:films/core/error/failure.dart';
import 'package:films/core/usecases/use_case.dart';
import 'package:films/feature/domain/entities/film_entity.dart';
import 'package:films/feature/domain/repositories/film_repository.dart';

class GetAllFilms extends UseCase<List<FilmEntity>, PageFilmParams> {
  final FilmRepository filmRepository;

  GetAllFilms(this.filmRepository);

  @override
  Future<Either<Failure, List<FilmEntity>>> call(PageFilmParams params) async {
    return await filmRepository.getPopularFilms(params.page);
  }
}

class PageFilmParams extends Equatable {
  final int page;
  const PageFilmParams({
    required this.page,
  });

  @override
  List<Object?> get props => [page];
}
