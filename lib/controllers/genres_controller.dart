// ignore_for_file: prefer_const_declarations

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:movie_app/models/genre_models.dart';

class GenresController extends GetxController {
  RxList<Genres1> genres = <Genres1>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchGenreData();
  }

  Future<void> fetchGenreData() async {
    final apiKey = '928f21d80c12084e5af6318f8611a904';
    final apiUrl = 'https://api.themoviedb.org/3/genre/movie/list';

    try {
      final response = await http.get(Uri.parse('$apiUrl?api_key=$apiKey'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> genresData = data['genres'];

        genres.assignAll(
          genresData.map((genre) => Genres1.fromJson(genre)).toList(),
        );
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      Get.snackbar(
        'Error',
        'Error fetching the data',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
