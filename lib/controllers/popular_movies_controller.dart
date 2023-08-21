// ignore_for_file: prefer_const_declarations, unnecessary_overrides

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:movie_app/models/popular_movies_model.dart';

class PopularMoviesController extends GetxController {
  RxList<Results> popularMovies = <Results>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchPopularMovies();
  }

  Future<void> fetchPopularMovies() async {
    final apiKey = '928f21d80c12084e5af6318f8611a904';
    final apiUrl = 'http://api.themoviedb.org/3/movie/popular';

    try {
      final response = await http.get(Uri.parse('$apiUrl?api_key=$apiKey'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> popularMoviesData = data['results'];

        popularMovies.value =
            popularMoviesData.map((movie) => Results.fromJson(movie)).toList();
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
}
