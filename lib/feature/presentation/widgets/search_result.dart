import 'package:films/feature/presentation/pages/film_details.dart';
import 'package:films/feature/presentation/widgets/film_cach_image.dart';
import 'package:flutter/material.dart';

import 'package:films/feature/domain/entities/film_entity.dart';

class SearchResult extends StatelessWidget {
  final FilmEntity filmResult;
  const SearchResult({
    super.key,
    required this.filmResult,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FilmDetails(film: filmResult)));
      },
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 2.0,
          child: Column(
            children: [
              SizedBox(
                height: 300,
                width: double.infinity,
                child: FilmCacheImage(
                  imageUrl:
                      "https://image.tmdb.org/t/p/w500${filmResult.posterPath}",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  filmResult.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400, fontSize: 25),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  filmResult.releaseDate,
                  style: const TextStyle(
                      fontWeight: FontWeight.w300, fontSize: 20),
                ),
              )
            ],
          )),
    );
  }
}
