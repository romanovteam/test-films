import 'package:equatable/equatable.dart';

import 'package:films/feature/domain/entities/film_entity.dart';

abstract class FilmState extends Equatable {
  const FilmState();
  @override
  List<Object?> get props => [];
}

class FilmEmpty extends FilmState {
  @override
  List<Object?> get props => [];
}

class FilmLoading extends FilmState {
  final List<FilmEntity> oldFilmsList;
  final bool isFirstFetch;
  const FilmLoading(this.oldFilmsList, {this.isFirstFetch = false});

  @override
  List<Object?> get props => [oldFilmsList];
}

class FilmLoaded extends FilmState {
  final List<FilmEntity> filmList;
  const FilmLoaded(this.filmList);
  @override
  List<Object?> get props => [filmList];
}

class FilmError extends FilmState {
  final String message;
  const FilmError({required this.message});

  @override
  List<Object?> get props => [message];
}
