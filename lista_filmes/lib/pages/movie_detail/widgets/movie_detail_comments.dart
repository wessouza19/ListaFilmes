import 'package:flutter/material.dart';
import 'package:lista_filmes/data/models/movie.dart';
import 'package:timeago/timeago.dart' as timeago;

class MovieDetailCommentsWidget extends StatelessWidget {
  const MovieDetailCommentsWidget({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: movie.comments.length,
      itemBuilder: (context, index) {
        var comment = movie.comments[index];

        return ListTile(
          title: Text(
            comment.comment,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          subtitle: Row(
            children: [
              Text(timeago.format(comment.createdAt)),
              const SizedBox(width: 12.0),
              const Text('•'),
              TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                      visualDensity: VisualDensity.compact),
                  child: const Text('Excluir')),
            ],
          ),
        );
      },
    );
  }
}
