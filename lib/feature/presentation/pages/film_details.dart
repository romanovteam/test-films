import 'package:films/feature/presentation/widgets/film_cach_image.dart';
import 'package:flutter/material.dart';
import 'package:films/feature/domain/entities/film_entity.dart';

class FilmDetails extends StatelessWidget {
  final FilmEntity film;

  const FilmDetails({
    super.key,
    required this.film,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  film.title,
                  style: const TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Center(
                child: FilmCacheImage(
                  imageUrl: "https://image.tmdb.org/t/p/w500${film.posterPath}",
                ),
              ),
              const SizedBox(height: 15),
              Text(
                'Release Date: ${film.releaseDate}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Rating: ${film.voteAverage} (${film.voteCount} votes)',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Popularity: ${film.popularity}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Overview',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                film.overview,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
