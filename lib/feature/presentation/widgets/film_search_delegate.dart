import 'package:films/feature/domain/entities/film_entity.dart';
import 'package:films/feature/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:films/feature/presentation/bloc/search_bloc/search_event.dart';
import 'package:films/feature/presentation/bloc/search_bloc/search_state.dart';
import 'package:films/feature/presentation/widgets/search_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilmSearchDelegate extends SearchDelegate {
  FilmSearchDelegate() : super(searchFieldLabel: 'Search movies here ...');

  final _sugg = ['Alice in Terrorland', 'Inside Out 2'];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back_sharp));
  }

  @override
  Widget buildResults(BuildContext context) {
    BlocProvider.of<FilmSearchBloc>(context, listen: false)
        .add(SearchFilms(filmQuery: query));
    return BlocBuilder<FilmSearchBloc, FilmSearchState>(
        builder: (context, state) {
      if (state is FilmSearchLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is FilmSearchLoaded) {
        final film = state.films;
        if (film.isEmpty) {
          return _showError('Not found this movie');
        }
        return ListView.builder(
            itemCount: film.isNotEmpty ? film.length : 0,
            itemBuilder: (context, int index) {
              FilmEntity movies = film[index];
              return SearchResult(filmResult: movies);
            });
      } else if (state is FilmSearchError) {
        return _showError(state.message);
      } else {
        return const Center(
          child: Icon(Icons.now_wallpaper),
        );
      }
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) {
      return Container();
    }

    return ListView.separated(
      padding: const EdgeInsets.all(10),
      itemBuilder: (context, index) {
        return Text(
          _sugg[index],
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
      itemCount: _sugg.length,
    );
  }
}

Widget _showError(String errorMessage) {
  return Container(
    color: const Color.fromARGB(255, 76, 9, 5),
    child: Text(
      errorMessage,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
    ),
  );
}
