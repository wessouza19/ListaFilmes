import 'package:lista_filmes/data/models/movie_comment.dart';

class Movie {
  Movie(
      {required this.id,
      required this.name,
      required this.year,
      required this.duration,
      required this.description,
      required this.gender,
      required this.urlimage,
      required this.comments});

  final int id;
  final String name;
  final int year;
  final int duration;
  final String description;
  final String gender;
  final String urlimage;
  final List<MovieComment> comments;

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        id: json['id'],
        name: json['name'],
        year: json['year'],
        duration: json['duration'],
        description: json['description'],
        gender: json['gender'],
        urlimage: json['url_image'],
        comments: ((json['comments'] ?? []) as List)
            .map((item) => MovieComment.fromJson(item))
            .toList(),
      );
}
