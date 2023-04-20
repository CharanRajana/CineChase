import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:cinechase/src/presentation/screens/movies_details_screen/movies_details_screen.dart';
import '../../core/assets.dart';
import '../../core/constants.dart';
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
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
            ),
          ),
          SizedBox(
            height: 280,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return OpenContainer(
                  closedColor: Colors.transparent,
                  openBuilder: (context, action) =>
                      MovieDetailsScreen(id: movies[index].id),
                  closedBuilder: (context, action) {
                    return SizedBox(
                      width: 350,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AspectRatio(
                            aspectRatio: 16 / 9,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Stack(
                                children: [
                                  FadeInImage(
                                    width: double.infinity,
                                    placeholder: const AssetImage(
                                      Assets.placeholder,
                                    ),
                                    image: movies[index].posterPath == ''
                                        ? const AssetImage(
                                            Assets.placeholder,
                                          ) as ImageProvider
                                        : NetworkImage(
                                            Constants.posterPrefix +
                                                movies[index].posterPath,
                                          ),
                                    fit: BoxFit.fitWidth,
                                  ),
                                  const Positioned.fill(
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.transparent,
                                            Colors.black,
                                            // Theme.of(context)
                                            //     .colorScheme
                                            //     .onPrimaryContainer,
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16, horizontal: 16),
                                      child: Text(
                                        movies[index].title,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
