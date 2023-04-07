import 'package:flutter/material.dart';
import '../components/horizontal_list_card.dart';
import '../../data/movies_api_client/models/movies_model.dart';

class MoviesList extends StatelessWidget {
  const MoviesList({
    super.key,
    required this.title,
    required this.movies,
    this.axis = Axis.horizontal,
  });

  final String title;
  final List<Movie> movies;
  final Axis axis;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10.0),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
            ),
          ),
          horizontalMoviesList(movies, context),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
