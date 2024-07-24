import 'package:equatable/equatable.dart';

abstract class FilmSearchEvent extends Equatable {
  const FilmSearchEvent();
  @override
  List<Object> get props => [];
}

class SearchFilms extends FilmSearchEvent {
  final String filmQuery;
  const SearchFilms({
    required this.filmQuery,
  });
}
