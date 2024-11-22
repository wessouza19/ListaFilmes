import 'package:flutter/material.dart';
import 'package:lista_filmes/data/models/movie.dart';
import 'package:lista_filmes/pages/movie_detail/widgets/add_comment_widget.dart';
import 'package:lista_filmes/pages/movie_detail/widgets/movie_detail_about_widget.dart';
import 'package:lista_filmes/pages/movie_detail/widgets/movie_detail_comments.dart';
import 'package:lista_filmes/pages/movie_detail/widgets/movie_detail_cover_widget.dart';
//import 'package:lista_filmes/pages/movie_list/widgets/movie_item_widget.dart';
import 'package:lista_filmes/pages/movie_list/widgets/progress_indicator_widget.dart';
import 'package:lista_filmes/service_locator.dart';
//import 'package:lista_filmes/pages/movie_list/movie_list_controller.dart';
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
        backgroundColor: Color.alphaBlend(
            Colors.black12, Theme.of(context).scaffoldBackgroundColor),
        body: StreamBuilder<Movie>(
          initialData: widget.movie,
          stream: controller.stream,
          builder: (context, snapshot) {
            var movie = snapshot.data!;

            //  if (snapshot.connectionState == ConnectionState.waiting) {
            //     return const ProgressIndicatorWidget();
            //  }

            return CustomScrollView(
              slivers: [
                MovieDetailCoverWidget(
                  movie: movie,
                ),
                MovieDetailAboutWidget(
                  movie: movie,
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 16.0, left: 16.0, right: 16.0),
                    child: Text(
                      'Comentários',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
                if (snapshot.connectionState == ConnectionState.waiting)
                  const SliverToBoxAdapter(child: ProgressIndicatorWidget())
                else if (movie.comments.isEmpty)
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    sliver: SliverToBoxAdapter(
                      child: Text(
                        'Seja o primeiro a comentar esse filme',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  )
                else
                  MovieDetailCommentsWidget(
                    movie: movie,
                  ),
                const AddCommentWidget(),
              ],
            );
          },
        ));
  }
}
