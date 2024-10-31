import 'package:flutter/material.dart';
import 'package:lista_filmes/data/models/movie.dart';
import 'package:lista_filmes/pages/movie_list/widgets/movie_item_widget.dart';
import 'package:lista_filmes/pages/movie_list/widgets/progress_indicator_widget.dart';
import 'package:lista_filmes/service_locator.dart';
import 'package:lista_filmes/pages/movie_list/movie_list_controller.dart';

class MovieListPage extends StatefulWidget {
  const MovieListPage({super.key});

  @override
  State<MovieListPage> createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  final controller = getIt<MovieListController>();

  @override
  void initState() {
    controller.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Movie App'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
          ],
        ),
        body: StreamBuilder<List<Movie>>(
          stream: controller.stream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const ProgressIndicatorWidget();
            }

            var movies = snapshot.data!;

            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                var movie = movies[index];

                return MovieItemWidget(
                  movie: movie,
                );
              },
            );
          },
        ));
  }
}
