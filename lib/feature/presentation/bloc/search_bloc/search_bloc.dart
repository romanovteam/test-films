import 'dart:async';

import 'package:films/core/error/failure.dart';
import 'package:films/feature/domain/usecases/search_film.dart';
import 'package:films/feature/presentation/bloc/search_bloc/search_event.dart';
import 'package:films/feature/presentation/bloc/search_bloc/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: constant_identifier_names
const SERVER_FAILURE_MESSAGE = 'Server Failure';
// ignore: constant_identifier_names
const CACHED_FAILURE_MESSAGE = 'Cache Failure';

class FilmSearchBloc extends Bloc<FilmSearchEvent, FilmSearchState> {
  final SearchFilm searchFilm;
  FilmSearchBloc({required this.searchFilm}) : super(FilmSearchEmpty()) {
    on<SearchFilms>(_onEvent);
  }

  FutureOr<void> _onEvent(
      SearchFilms event, Emitter<FilmSearchState> emit) async {
    emit(FilmSearchLoading());
    final failureOrFilm =
        await searchFilm(SearchFilmParams(query: event.filmQuery));
    emit(failureOrFilm.fold(
        (failure) => FilmSearchError(message: _mapFailureToMessage(failure)),
        (person) => FilmSearchLoaded(films: person)));
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
