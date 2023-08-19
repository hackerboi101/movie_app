import 'package:flutter/material.dart';
import 'package:movie_app/views/utils/bottom_navigation_bar.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(27, 35, 48, 1),
      body: const Center(
        child: Text('Home Page'),
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
