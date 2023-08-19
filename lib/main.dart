import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/views/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(27, 35, 48, 1),
        ),
        fontFamily: 'Poppins',
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
