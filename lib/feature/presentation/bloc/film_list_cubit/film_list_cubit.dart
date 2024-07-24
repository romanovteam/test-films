import 'package:films/core/error/failure.dart';
import 'package:films/feature/domain/entities/film_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:films/feature/domain/usecases/get_all_films.dart';
import 'package:films/feature/presentation/bloc/film_list_cubit/film_list_state.dart';

// ignore: constant_identifier_names
const SERVER_FAILURE_MESSAGE = 'Server Failure';
// ignore: constant_identifier_names
const CACHED_FAILURE_MESSAGE = 'Cache Failure';

class FilmListCubit extends Cubit<FilmState> {
  final GetAllFilms getAllFilms;
  FilmListCubit({
    required this.getAllFilms,
  }) : super(FilmEmpty());

  int page = 1;

  void loadFilm() async {
    if (state is FilmLoading) return;
    final currentState = state;
    var oldFilm = <FilmEntity>[];
    if (currentState is FilmLoaded) {
      oldFilm = currentState.filmList;
    }

    emit(FilmLoading(oldFilm, isFirstFetch: page == 1));

    final failureOrFilm = await getAllFilms(PageFilmParams(page: page));

    failureOrFilm
        .fold((error) => emit(FilmError(message: _mapFailureToMessage(error))),
            (film) {
      page++;
      final films = (state as FilmLoading).oldFilmsList;
      films.addAll(film);
      emit(FilmLoaded(films));
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case const (ServerFailure):
        return SERVER_FAILURE_MESSAGE;
      case const (CacheFailure):
        return CACHED_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
