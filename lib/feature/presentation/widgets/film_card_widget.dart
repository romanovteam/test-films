import 'package:films/common/app_colors.dart';
import 'package:films/feature/presentation/pages/film_details.dart';
import 'package:films/feature/presentation/widgets/film_cach_image.dart';
import 'package:flutter/material.dart';
import 'package:films/feature/domain/entities/film_entity.dart';

class FilmCard extends StatelessWidget {
  final FilmEntity film;
  const FilmCard({
    super.key,
    required this.film,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  FilmDetails(film: film), // Передача film в детали
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.cellBackground,
            borderRadius: BorderRadius.circular(13),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final screenWidth = constraints.maxWidth;
              final screenHeight = MediaQuery.of(context).size.height;

              final imageWidth = screenWidth * 0.99;
              final imageHeight = screenHeight * 0.25;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          film.title,
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${film.voteAverage}',
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: imageWidth,
                    height: imageHeight,
                    margin: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(13),
                      child: FilmCacheImage(
                        imageUrl:
                            "https://image.tmdb.org/t/p/w500${film.posterPath}",
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
