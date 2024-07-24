import 'package:dartz/dartz.dart';
import 'package:films/core/error/ecxeption.dart';

import 'package:films/core/error/failure.dart';
import 'package:films/core/platform/network_info.dart';
import 'package:films/feature/data/datasourses/film_local_data_sourse.dart';
import 'package:films/feature/data/datasourses/film_remote_data_sourse.dart';
import 'package:films/feature/data/models/film_model.dart';
import 'package:films/feature/domain/entities/film_entity.dart';
import 'package:films/feature/domain/repositories/film_repository.dart';

class FilmRepositoryImpl implements FilmRepository {
  final FilmRemoteDataSource remoteDataSource;
  final FilmLocalDataSourse localDataSourse;
  final NetWorkInfo networkInfo;
  FilmRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSourse,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, List<FilmEntity>>> getPopularFilms(int page) async {
    return await _getFilms(() {
      return remoteDataSource.getAllFilms(page);
    });
  }

  @override
  Future<Either<Failure, List<FilmEntity>>> searchFilms(String query) async {
    return await _getFilms(() {
      return remoteDataSource.searchFilm(query);
    });
  }

  Future<Either<Failure, List<FilmModel>>> _getFilms(
      Future<List<FilmModel>> Function() getFilms) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteFilm = await getFilms();
        localDataSourse.filmsToCache(remoteFilm);
        return Right(remoteFilm);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final locationFilm = await localDataSourse.getLastFilmsFromCache();
        return Right(locationFilm);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
