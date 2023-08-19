// ignore_for_file: prefer_const_declarations, unnecessary_overrides

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:movie_app/models/movies_in_genre_model.dart';

class MoviesInGenreController extends GetxController {
  RxList<Results> moviesInGenre = <Results>[].obs;

  final RxString genreName = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> fetchMoviesInGenre(int genreId) async {
    moviesInGenre.clear();
    final apiKey = '928f21d80c12084e5af6318f8611a904';
    final apiUrl =
        'https://api.themoviedb.org/3/discover/movie?with_genres=$genreId';

    try {
      final response = await http.get(Uri.parse('$apiUrl&api_key=$apiKey'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> moviesInGenreData = data['results'];

        moviesInGenre.value =
            moviesInGenreData.map((movie) => Results.fromJson(movie)).toList();
      } else {
        Get.snackbar(
          'Error',
          'Error fetching the data from the API. Status code: ${response.statusCode}',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (error) {
      Get.snackbar(
        'Error',
        'Error fetching the data. $error',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> fetchGenreName(String name) async {
    genreName.value = name;
  }
}
