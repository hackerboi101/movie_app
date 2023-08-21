// ignore_for_file: prefer_const_declarations, unnecessary_overrides

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:movie_app/models/search_results_model.dart';

class SearchResultsController extends GetxController {
  RxList<Results> searchResults = <Results>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> fetchSearchResults(String movieTitle) async {
    final apiKey = '928f21d80c12084e5af6318f8611a904';
    final apiUrl = 'https://api.themoviedb.org/3/search/movie';

    try {
      final response = await http
          .get(Uri.parse('$apiUrl?api_key=$apiKey&query=$movieTitle'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> searchResultsData = data['results'];
        final int totalPages = data['total_pages'];

        searchResults.value =
            searchResultsData.map((movie) => Results.fromJson(movie)).toList();

        if (totalPages > 1) {
          for (int currentPage = 2; currentPage <= totalPages; currentPage++) {
            final nextPageResponse = await http.get(Uri.parse(
                '$apiUrl?api_key=$apiKey&query=$movieTitle&page=$currentPage'));
            final Map<String, dynamic> nextPageData =
                json.decode(nextPageResponse.body);
            final List<dynamic> nextPageResults = nextPageData['results'];

            searchResults.addAll(nextPageResults
                .map((movie) => Results.fromJson(movie))
                .toList());
          }
        }
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
