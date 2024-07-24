import 'package:equatable/equatable.dart';

import 'package:films/feature/domain/entities/film_entity.dart';

abstract class FilmSearchState extends Equatable {
  const FilmSearchState();
  @override
  List<Object> get props => [];
}

class FilmSearchEmpty extends FilmSearchState {}

class FilmSearchLoading extends FilmSearchState {}

class FilmSearchLoaded extends FilmSearchState {
  final List<FilmEntity> films;
  const FilmSearchLoaded({
    required this.films,
  });
  @override
  List<Object> get props => [films];
}

class FilmSearchError extends FilmSearchState {
  final String message;
  const FilmSearchError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
