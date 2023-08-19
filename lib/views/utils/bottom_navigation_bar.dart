// ignore_for_file: use_key_in_widget_constructors, avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/views/home_page.dart';
import 'package:movie_app/views/search_page.dart';
import 'package:movie_app/views/favorites_page.dart';

class BottomNavigationController extends GetxController {
  final RxInt selectedIndex = 0.obs;

  void onItemTapped(int index) {
    selectedIndex.value = index;
    if (index == 0) {
      Get.to(HomePage());
    } else if (index == 1) {
      Get.to(SearchPage());
    } else if (index == 2) {
      Get.to(FavoritesPage());
    }
  }
}

class BottomNavigation extends StatelessWidget {
  final BottomNavigationController controller =
      Get.put(BottomNavigationController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        color: Color.fromRGBO(37, 47, 64, 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          onTap: controller.onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                color: controller.selectedIndex.value == 0
                    ? Color.fromARGB(255, 43, 114, 105)
                    : Color.fromRGBO(128, 147, 202, 1),
              ),
              label: 'Home',
              activeIcon: Icon(
                Icons.home_outlined,
                color: Color.fromARGB(255, 43, 114, 105),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search_outlined,
                color: controller.selectedIndex.value == 1
                    ? Color.fromARGB(255, 43, 114, 105)
                    : Color.fromRGBO(128, 147, 202, 1),
              ),
              label: 'Search',
              activeIcon: Icon(
                Icons.search_outlined,
                color: Color.fromARGB(255, 43, 114, 105),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite_border_outlined,
                color: controller.selectedIndex.value == 2
                    ? Color.fromARGB(255, 43, 114, 105)
                    : Color.fromRGBO(128, 147, 202, 1),
              ),
              label: 'Favorites',
              activeIcon: Icon(
                Icons.favorite_border_outlined,
                color: Color.fromARGB(255, 43, 114, 105),
              ),
            ),
          ],
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color.fromRGBO(37, 47, 64, 1),
          selectedItemColor: Color.fromARGB(255, 43, 114, 105),
          unselectedItemColor: Color.fromRGBO(128, 147, 202, 1),
        ),
      ),
    );
  }
}
