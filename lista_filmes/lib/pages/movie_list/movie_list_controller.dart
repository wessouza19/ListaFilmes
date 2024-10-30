import 'dart:async';

import 'package:lista_filmes/data/models/movie.dart';
import 'package:lista_filmes/data/models/movie_api.dart';
import 'package:lista_filmes/service_locator.dart';

class MovieListController {
  final api = getIt<MovieApi>();

  final _controller = StreamController<List<Movie>>();
  Stream<List<Movie>> get stream => _controller.stream;

  void init() {
    getMovies();
  }

  Future<void> getMovies() async {
    var result = await api.getMovies();

    _controller.sink.add(result);
  }
}
