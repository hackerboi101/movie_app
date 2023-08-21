import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/controllers/movie_details_controller.dart';
import 'package:movie_app/controllers/movies_in_genre_controller.dart';
import 'package:movie_app/controllers/popular_movies_controller.dart';
import 'package:movie_app/controllers/trailers_controller.dart';
import 'package:movie_app/controllers/trending_movies_controller.dart';
import 'package:movie_app/views/genre_page.dart';
import 'package:movie_app/views/movie_details_page.dart';
import 'package:movie_app/views/utils/bottom_navigation_bar.dart';
import 'package:movie_app/controllers/genres_controller.dart';
import 'package:movie_app/models/genre_models.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final GenresController genresController = Get.put(GenresController());
  final MoviesInGenreController moviesInGenreController =
      Get.put(MoviesInGenreController());
  final TrendingMoviesController trendingMoviesController =
      Get.put(TrendingMoviesController());
  final PopularMoviesController popularMoviesController =
      Get.put(PopularMoviesController());
  final MovieDetailsController movieDetailsController =
      Get.put(MovieDetailsController());
  final TrailersController trailersController = Get.put(TrailersController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(27, 35, 48, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(27, 35, 48, 1),
        automaticallyImplyLeading: false,
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
            const Text(
              'Trending Movies',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(189, 189, 189, 1),
              ),
            ),
            const SizedBox(height: 20),
            Obx(
              () {
                final trendingMovies = trendingMoviesController.trendingMovies;
                if (trendingMovies.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                return SizedBox(
                  height: 250,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: trendingMovies.length,
                    itemBuilder: (context, index) {
                      final movie = trendingMovies[index];

                      return GestureDetector(
                        onTap: () async {
                          await movieDetailsController
                              .fetchMovieDetails(movie.id!);
                          await trailersController.fetchTrailers(movie.id!);
                          Get.to(MovieDetailsPage());
                        },
                        child: Container(
                          width: 160,
                          margin: const EdgeInsets.only(right: 13),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 5,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Popular Movies',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(189, 189, 189, 1),
              ),
            ),
            const SizedBox(height: 20),
            Obx(
              () {
                final popularMovies = popularMoviesController.popularMovies;
                if (popularMovies.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                return SizedBox(
                  height: 250,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: popularMovies.length,
                    itemBuilder: (context, index) {
                      final movie = popularMovies[index];

                      return GestureDetector(
                        onTap: () async {
                          await movieDetailsController
                              .fetchMovieDetails(movie.id!);
                          await trailersController.fetchTrailers(movie.id!);
                          Get.to(MovieDetailsPage());
                        },
                        child: Container(
                          width: 160,
                          margin: const EdgeInsets.only(right: 13),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 5,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Genres',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(189, 189, 189, 1),
              ),
            ),
            const SizedBox(height: 20),
            Obx(
              () {
                final genreWidgets = genresController.genres
                    .map((genre) => buildGenreContainer(context, genre))
                    .toList();
                return Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: genreWidgets,
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }

  Widget buildGenreContainer(BuildContext context, Genres1 genre) {
    return GestureDetector(
      onTap: () async {
        await moviesInGenreController.fetchMoviesInGenre(genre.id!);
        await moviesInGenreController.fetchGenreName(genre.name!);
        Get.to(GenrePage());
      },
      child: Container(
        width: (MediaQuery.of(context).size.width - 40) / 2 - 5,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 43, 114, 105),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 5,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Center(
          child: Text(
            genre.name ?? '',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
