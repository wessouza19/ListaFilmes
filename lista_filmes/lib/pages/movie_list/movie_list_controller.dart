import 'dart:async';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lista_filmes/data/models/movie.dart';
import 'package:lista_filmes/data/models/movie_api.dart';
import 'package:lista_filmes/service_locator.dart';

class MovieListController {
  final api = getIt<MovieApi>();

  // final _controller = StreamController<List<Movie>>();
  // Stream<List<Movie>> get stream => _controller.stream;

  final int _pageSize = 20;
  final PagingController<int, Movie> pagingController =
      PagingController(firstPageKey: 0);

  void init() {
    pagingController.addPageRequestListener((pageKey) => getMovies(pageKey));
  }

  Future<void> getMovies(int pageKey) async {
    try {
      var newItems = await api.getMovies(skip: pageKey, take: _pageSize);
      final isLastPage = newItems.length < _pageSize;

      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }
  // _controller.sink.add(result);
}

// Future<void> getMovies() async {
//     var result = await api.getMovies();

//     _controller.sink.add(result);
    
//   }

//}
