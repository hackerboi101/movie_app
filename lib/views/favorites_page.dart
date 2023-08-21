import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/controllers/favorites_controller.dart';
import 'package:movie_app/controllers/movie_details_controller.dart';
import 'package:movie_app/controllers/trailers_controller.dart';
import 'package:movie_app/models/movie_details_model.dart';
import 'package:movie_app/views/movie_details_page.dart';
import 'package:movie_app/views/utils/bottom_navigation_bar.dart';

class FavoritesPage extends StatelessWidget {
  FavoritesPage({super.key});

  final FavoritesController favoritesController =
      Get.put(FavoritesController());
  final MovieDetailsController movieDetailsController =
      Get.put(MovieDetailsController());
  final TrailersController trailersController = Get.put(TrailersController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(27, 35, 48, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(27, 35, 48, 1),
        centerTitle: true,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 43, 114, 105),
        ),
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
              'Your Favorite Movies',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(189, 189, 189, 1),
              ),
            ),
            const SizedBox(height: 20),
            Obx(
              () {
                final List<MovieDetails> favorites =
                    favoritesController.favorites;
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: favorites.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final movie = favorites[index];
                    return GestureDetector(
                      onTap: () async {
                        await movieDetailsController
                            .fetchMovieDetails(movie.id!);
                        await trailersController.fetchTrailers(movie.id!);
                        Get.to(MovieDetailsPage());
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 10),
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
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: Obx(
                                () => GestureDetector(
                                  onTap: () {
                                    if (favoritesController
                                        .isMovieFavorite(movie.id!)) {
                                      favoritesController
                                          .removeFromFavorites(movie.id!);
                                    } else {
                                      favoritesController.addToFavorites(movie);
                                    }
                                  },
                                  child: favoritesController
                                          .isMovieFavorite(movie.id!)
                                      ? const Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        )
                                      : const Icon(
                                          Icons.favorite_border_outlined,
                                          color:
                                              Color.fromRGBO(189, 189, 189, 1),
                                        ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
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
}
