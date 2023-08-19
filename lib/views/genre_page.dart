import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/controllers/movies_in_genre_controller.dart';
import 'package:movie_app/models/movies_in_genre_model.dart';
import 'package:movie_app/views/utils/bottom_navigation_bar.dart';

class GenrePage extends StatelessWidget {
  GenrePage({Key? key}) : super(key: key);

  final MoviesInGenreController moviesInGenreController =
      Get.put(MoviesInGenreController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(27, 35, 48, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(27, 35, 48, 1),
        centerTitle: true,
        title: Column(
          children: [
            Image.asset(
              'assets/images/app_logo.png',
              width: 30,
              height: 30,
            ),
            const SizedBox(height: 3),
            const Text(
              'Movieto',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 43, 114, 105),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              '${moviesInGenreController.genreName} Movies',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(189, 189, 189, 1),
              ),
            ),
            Obx(
              () {
                final movies = moviesInGenreController.moviesInGenre;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7, // Adjust this for your needs
                  ),
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    final movie = movies[index];
                    return buildMovieCard(movie);
                  },
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }

  Widget buildMovieCard(Results movie) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 5,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Movie poster
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              'https://image.tmdb.org/t/p/w500${movie.posterPath}',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          // Movie details at top left corner
          Positioned(
            top: 10,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.originalTitle ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  movie.releaseDate ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
