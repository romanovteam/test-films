import 'package:films/feature/domain/entities/film_entity.dart';
import 'package:films/feature/presentation/bloc/film_list_cubit/film_list_cubit.dart';
import 'package:films/feature/presentation/bloc/film_list_cubit/film_list_state.dart';
import 'package:films/feature/presentation/widgets/film_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilmsList extends StatelessWidget {
  final scrollController = ScrollController();
  final int page = -1;

  FilmsList({super.key});

  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          context.read<FilmListCubit>().loadFilm();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    return BlocBuilder<FilmListCubit, FilmState>(builder: (context, state) {
      List<FilmEntity> films = [];
      bool isLoading = false;
      if (state is FilmLoading && state.isFirstFetch) {
        return _loadingIndicator();
      } else if (state is FilmLoading) {
        films = state.oldFilmsList;
        isLoading = true;
      } else if (state is FilmLoaded) {
        films = state.filmList;
      } else if (state is FilmError) {
        return Text(
          state.message,
          style: const TextStyle(color: Colors.white, fontSize: 25),
        );
      }
      return ListView.separated(
          controller: scrollController,
          itemBuilder: (context, index) {
            if (index < films.length) {
              return FilmCard(film: films[index]);
            } else {
              return _loadingIndicator();
            }
          },
          separatorBuilder: (context, index) {
            return Divider(
              color: Colors.amber[200],
            );
          },
          itemCount: films.length + (isLoading ? 1 : 0));
    });
  }
}

Widget _loadingIndicator() {
  return const Padding(
    padding: EdgeInsets.all(16.0),
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );
}
