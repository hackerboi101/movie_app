import 'package:get/get.dart';
import 'package:movie_app/controllers/movie_details_controller.dart';
import 'package:movie_app/models/movie_details_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesController extends GetxController {
  final _favoritesKey = 'favorites';
  RxList<MovieDetails> favorites = <MovieDetails>[].obs;

  final MovieDetailsController movieDetailsController =
      Get.put(MovieDetailsController());

  @override
  Future<void> onInit() async {
    super.onInit();
    await loadFavorites();
  }

  void addToFavorites(MovieDetails movie) async {
    favorites.add(movie);
    await saveFavorites();
  }

  void removeFromFavorites(int movieId) async {
    favorites.removeWhere((movie) => movie.id == movieId);
    await saveFavorites();
  }

  bool isMovieFavorite(int movieId) {
    return favorites.any((movie) => movie.id == movieId);
  }

  Future<void> saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteIds = favorites.map((movie) => movie.id.toString()).toList();
    await prefs.setStringList(_favoritesKey, favoriteIds);
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteIds = prefs.getStringList(_favoritesKey);

    if (favoriteIds != null) {
      for (final id in favoriteIds) {
        await movieDetailsController.fetchMovieDetails(int.parse(id));
        final movie = movieDetailsController.movieDetails
            .firstWhereOrNull((movie) => movie.id == int.parse(id));

        if (movie != null) {
          favorites.add(movie);
        }
      }
    }
  }
}
