import 'package:flutter/material.dart';
import 'package:lista_filmes/movie_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF15173D),
        colorScheme: const ColorScheme.dark(primary: Color(0xffbb86fc)),
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF15173D)),
        useMaterial3: true,
      ),
      home: const MovieListPage(),
    );
  }
}
