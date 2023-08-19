// trailers_controller.dart
// ignore_for_file: unnecessary_overrides, prefer_const_declarations

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:movie_app/models/trailers_model.dart';

class TrailersController extends GetxController {
  RxList<Results> trailers = <Results>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> fetchTrailers(int movieId) async {
    final apiKey = '928f21d80c12084e5af6318f8611a904';
    final apiUrl = 'https://api.themoviedb.org/3/movie/$movieId/videos';

    try {
      final response = await http.get(Uri.parse('$apiUrl?api_key=$apiKey'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final Trailers trailersData = Trailers.fromJson(data);

        trailers.value = trailersData.results!
            .where((trailer) =>
                trailer.type == 'Trailer' && trailer.official == true)
            .toList();
      } else {
        Get.snackbar(
          'Error',
          'Error fetching trailers. Status code: ${response.statusCode}',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (error) {
      Get.snackbar(
        'Error',
        'Error fetching trailers. $error',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
