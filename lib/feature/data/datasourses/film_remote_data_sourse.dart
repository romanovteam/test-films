import 'dart:convert';
import 'package:films/core/error/ecxeption.dart';
import 'package:films/feature/data/models/film_model.dart';
import 'package:http/http.dart' as http;

abstract class FilmRemoteDataSource {
  Future<List<FilmModel>> getAllFilms(int page);
  Future<List<FilmModel>> searchFilm(String query);
}

class FilmRemoteDataSourceImpl implements FilmRemoteDataSource {
  final http.Client client;
  final String apiKey;

  FilmRemoteDataSourceImpl({required this.client, required this.apiKey});

  @override
  Future<List<FilmModel>> getAllFilms(int page) async {
    return _getFilmsFromUrl(
        'https://api.themoviedb.org/3/movie/popular?api_key=$apiKey&language=en-US&page=$page');
  }

  @override
  Future<List<FilmModel>> searchFilm(String query) async {
    return _getFilmsFromUrl(
        'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&include_adult=false&language=en-US&query=$query');
  }

  Future<List<FilmModel>> _getFilmsFromUrl(String url) async {
    print(url);
    final response = await client.get(
      Uri.parse(url),
      headers: {'accept': 'application/json'},
    );
    if (response.statusCode == 200) {
      final films = json.decode(response.body);
      return (films['results'] as List)
          .map((film) => FilmModel.fromJson(film))
          .toList();
    } else {
      print(response);
      throw ServerException();
    }
  }
}
