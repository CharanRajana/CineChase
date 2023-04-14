import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:project32/src/presentation/screens/movies_details_screen/movies_details_screen.dart';
import '../../core/extras/assets.dart';
import '../../core/extras/constants.dart';
import '../../data/movies_api_client/models/movies_model.dart';

class MoviesList extends StatelessWidget {
  const MoviesList({
    super.key,
    required this.title,
    required this.movies,
  });

  final String title;
  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          SizedBox(
            height: 300,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return OpenContainer(
                  closedColor: Colors.transparent,
                  openBuilder: (context, action) =>
                      MovieDetailsScreen(id: movies[index].id),
                  closedBuilder: (context, action) {
                    return SizedBox(
                      width: 250,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridTile(
                            footer: GridTileBar(
                              backgroundColor: Colors.black54,
                              title: Text(
                                movies[index].title,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
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
                                      Constants.posterPrefix +
                                          movies[index].posterPath,
                                    ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  width: 10,
                );
              },
              itemCount: movies.length,
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
