import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/controllers/movies_in_genre_controller.dart';
import 'package:movie_app/views/genre_page.dart';
import 'package:movie_app/views/utils/bottom_navigation_bar.dart';
import 'package:movie_app/controllers/genres_controller.dart';
import 'package:movie_app/models/genre_models.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final GenresController genresController = Get.put(GenresController());
  final MoviesInGenreController moviesInGenreController =
      Get.put(MoviesInGenreController());

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
            const Text(
              'Popular Movies',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(189, 189, 189, 1),
              ),
            ),
            const Text(
              'Genres',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(189, 189, 189, 1),
              ),
            ),
            const SizedBox(height: 10),
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
        moviesInGenreController.fetchGenreName(genre.name!);
        Get.to(GenrePage());
      },
      child: Container(
        width: (MediaQuery.of(context).size.width - 40) / 2 -
            10, // Adjusted width for two containers per row
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(189, 189, 189, 1),
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
