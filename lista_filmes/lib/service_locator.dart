import 'package:get_it/get_it.dart';
import 'package:lista_filmes/data/models/movie_api.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerLazySingleton<MovieApi>(() => MovieApi());
}
