import 'package:flutter/material.dart';
import 'package:project32/src/core/extras/assets.dart';
import 'package:project32/src/presentation/screens/movies_details.dart';
import '../../core/extras/constants.dart';
import '../../data/movies_api_client/models/movies_model.dart';

SizedBox horizontalMoviesList(List<Movie> movies, BuildContext context) {
  return SizedBox(
    height: 300,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return SizedBox(
          width: 250,
          child: GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MovieDetailsScreen(id: movies[index].id),
              ),
            ),
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridTile(
                  footer: GridTileBar(
                    backgroundColor: Colors.black54,
                    title: Text(
                      movies[index].title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.amber,
                          ),
                    ),
                  ),
                  child: FadeInImage(
                    placeholder: const AssetImage(Assets.placeholder),
                    image: movies[index].posterPath == ''
                        ? const AssetImage(
                            Assets.placeholder,
                          ) as ImageProvider
                        : NetworkImage(
                            Constants.posterPrefix + movies[index].posterPath,
                          ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          width: 10,
        );
      },
      itemCount: movies.length,
    ),
  );
}
