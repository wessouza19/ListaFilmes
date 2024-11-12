import 'package:flutter/material.dart';
import 'package:lista_filmes/data/models/movie.dart';
import 'package:lista_filmes/pages/movie_detail/widgets/movie_detail_cover_widget.dart';
import 'package:lista_filmes/pages/movie_list/widgets/movie_item_widget.dart';
import 'package:lista_filmes/pages/movie_list/widgets/progress_indicator_widget.dart';
import 'package:lista_filmes/service_locator.dart';
import 'package:lista_filmes/pages/movie_list/movie_list_controller.dart';
import 'package:lista_filmes/pages/movie_detail/movie_detail_controller.dart';

class MovieDetailPage extends StatefulWidget {
  const MovieDetailPage({super.key, required this.movie});

  final Movie movie;

  @override
  State<MovieDetailPage> createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieDetailPage> {
  final controller = getIt.registerSingleton(MovieDetailController());

  @override
  void initState() {
    controller.init(widget.movie);
    super.initState();
  }

  @override
  void dispose() {
    getIt.unregister(instance: controller);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var movie = widget.movie;

    return Scaffold(
        body: StreamBuilder<Movie>(
      initialData: widget.movie,
      stream: controller.stream,
      builder: (context, snapshot) {
        var movie = snapshot.data!;
        // if (snapshot.connectionState == ConnectionState.waiting) {
        //  return const ProgressIndicatorWidget();
        // }

        return CustomScrollView(
          slivers: [
            MovieDetailCoverWidget(
              movie: movie,
            ),
          ],
        );
      },
    ));
  }
}
