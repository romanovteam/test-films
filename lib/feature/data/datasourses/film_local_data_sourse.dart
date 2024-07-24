import 'dart:convert';

import 'package:films/core/error/ecxeption.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:films/feature/data/models/film_model.dart';

abstract class FilmLocalDataSourse {
  Future<List<FilmModel>> getLastFilmsFromCache();
  Future<void> filmsToCache(List<FilmModel> films);
}

// ignore: constant_identifier_names
const CACHED_FILM_LIST = 'CACHED_FILMLIST';

class FilmLocalDataSourseImpl implements FilmLocalDataSourse {
  final SharedPreferences sharedPreferences;
  FilmLocalDataSourseImpl({
    required this.sharedPreferences,
  });

  @override
  Future<List<FilmModel>> getLastFilmsFromCache() {
    final jsonFilmsList = sharedPreferences.getStringList(CACHED_FILM_LIST);
    if (jsonFilmsList!.isNotEmpty) {
      return Future.value(jsonFilmsList
          .map((film) => FilmModel.fromJson(jsonDecode(film)))
          .toList());
    } else {
      throw CacheException();
    }
  }

  @override
  Future<List<String>> filmsToCache(List<FilmModel> films) {
    final List<String> jsonFilmsList =
        films.map((person) => json.encode(person.toJson())).toList();
    sharedPreferences.setStringList(CACHED_FILM_LIST, jsonFilmsList);
    print('Films to write Cache: ${jsonFilmsList.length}');
    return Future.value(jsonFilmsList);
  }
}
