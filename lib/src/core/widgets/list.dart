import 'package:flutter/material.dart';
import 'package:project32/src/features/movies/presentation/screens/movies_details.dart';

import '../../features/movies/data/movies_api_client/models/models.dart';
import '../constants.dart';

SizedBox list(List<Movie> movies, BuildContext context, Axis axis) {
  return SizedBox(
    height: 300,
    child: ListView(
      scrollDirection: axis,
      children: [
        for (final item in movies)
          SizedBox(
            width: 250,
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MovieDetailsScreen(id: item.id),
                ),
              ),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridTile(
                    footer: GridTileBar(
                      backgroundColor: Colors.black54,
                      title: Text(
                        item.title,
                        textAlign: TextAlign.center,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber,
                                ),
                      ),
                    ),
                    child: Image(
                      image: NetworkImage(
                          Constants.posterPrefix + item.posterPath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    ),
  );
}
