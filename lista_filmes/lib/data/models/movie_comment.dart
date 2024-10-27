class MovieComment {
  MovieComment(
      {required this.id, required this.comments, required this.createdAt});

  final int id;
  final String comments;
  final DateTime createdAt;

  factory MovieComment.fromJson(Map<String, dynamic> json) => MovieComment(
        id: json['id'],
        comments: json['comments'],
        createdAt: DateTime.parse(json['date_created']),
      );
}
