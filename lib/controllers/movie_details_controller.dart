// ignore_for_file: unnecessary_overrides, prefer_const_declarations

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:movie_app/models/movie_details_model.dart';

class MovieDetailsController extends GetxController {
  RxList<MovieDetails> movieDetails = <MovieDetails>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> fetchMovieDetails(int movieId) async {
    final apiKey = '928f21d80c12084e5af6318f8611a904';
    final apiUrl = 'https://api.themoviedb.org/3/movie/$movieId';

    try {
      final response = await http.get(Uri.parse('$apiUrl?api_key=$apiKey'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final MovieDetails movieDetailsData = MovieDetails.fromJson(data);

        movieDetails.value = [movieDetailsData]
            .map((movie) => MovieDetails.fromJson(movie.toJson()))
            .toList();
      } else {
        Get.snackbar(
          'Error',
          'Error fetching movie details. Status code: ${response.statusCode}',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (error) {
      Get.snackbar(
        'Error',
        'Error fetching movie details. $error',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
