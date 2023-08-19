import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/controllers/movie_details_controller.dart';
import 'package:movie_app/controllers/trailers_controller.dart';
import 'package:movie_app/views/trailer_player_page.dart';
import 'package:movie_app/views/utils/bottom_navigation_bar.dart';

class MovieDetailsPage extends StatelessWidget {
  MovieDetailsPage({Key? key}) : super(key: key);

  final MovieDetailsController movieDetailsController =
      Get.put(MovieDetailsController());
  final TrailersController trailersController = Get.put(TrailersController());

  final RxBool isFavorite = false.obs;

  final double videoContainerSize = 390;

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
      body: Obx(() {
        final movieDetails = movieDetailsController.movieDetails.isNotEmpty
            ? movieDetailsController.movieDetails.first
            : null;

        if (movieDetails != null) {
          final releaseYear = DateFormat('yyyy')
              .format(DateTime.parse(movieDetails.releaseDate!));
          final runtimeFormatted =
              '${movieDetails.runtime! ~/ 60}h ${movieDetails.runtime! % 60}m';

          return SingleChildScrollView(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 5,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(13),
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w500${movieDetails.backdropPath}',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 200,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 19,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '${movieDetails.voteAverage} | ${movieDetails.voteCount} votes',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(189, 189, 189, 1),
                          ),
                        ),
                      ],
                    ),
                    Obx(
                      () => GestureDetector(
                        onTap: () {
                          isFavorite.value = !isFavorite.value;
                        },
                        child: isFavorite.value
                            ? const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                            : const Icon(
                                Icons.favorite_border_outlined,
                                color: Color.fromRGBO(189, 189, 189, 1),
                              ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  movieDetails.originalTitle!,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(189, 189, 189, 1),
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  movieDetails.genres!.map((genre) => genre.name!).join(', '),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(189, 189, 189, 1),
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  '$runtimeFormatted • $releaseYear',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(189, 189, 189, 1),
                  ),
                ),
                const SizedBox(height: 25),
                Text(
                  movieDetails.overview!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(189, 189, 189, 1),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Trailers',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(189, 189, 189, 1),
                  ),
                ),
                const SizedBox(height: 10),
                Obx(() {
                  final trailers = trailersController.trailers;

                  return SizedBox(
                    height: 249,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: trailers.length,
                      itemBuilder: (context, index) {
                        final trailer = trailers[index];

                        return GestureDetector(
                          onTap: () {
                            Get.to(
                                () => TrailerPlayerPage(videoId: trailer.key!));
                          },
                          child: Container(
                            width: videoContainerSize,
                            margin: const EdgeInsets.only(
                              right: 9,
                              left: 9,
                              bottom: 15,
                              top: 15,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 7,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    'https://img.youtube.com/vi/${trailer.key}/0.jpg',
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                                ),
                                Center(
                                  child: CircleAvatar(
                                    backgroundColor:
                                        Colors.grey.withOpacity(0.7),
                                    radius: 40,
                                    child: const Icon(
                                      Icons.play_arrow,
                                      size: 60,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
