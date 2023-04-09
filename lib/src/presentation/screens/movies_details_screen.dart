import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/extras/constants.dart';
import '../../core/extras/providers.dart';
import '../components/horizontal_movies.dart';
import '../components/interactive_rating_bar.dart';
import '../components/ratings_bar.dart';

class MovieDetailsScreen extends ConsumerWidget {
  const MovieDetailsScreen({
    super.key,
    required this.id,
  });

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movie = ref.watch(movieDetailsProvider(id));
    final ratings = ref.watch(ratingProvider);
    final recommendation = ref.watch(recommendedMoviesProvider(id));
    return movie.when(
      data: (movie) {
        return Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
          floatingActionButton: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: FloatingActionButton.small(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Icon(Icons.arrow_back_rounded),
            ),
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Hero(
                  tag: 'poster${movie.id}',
                  child: Stack(
                    children: [
                      Container(
                        height: 500,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              Constants.bgPrefix + movie.backdropPath,
                            ),
                            fit: BoxFit.cover,
                          ),
                          gradient: const LinearGradient(
                            colors: [Colors.black, Colors.transparent],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                      ),
                      Container(
                        height: 500,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          //color: Colors.white.withOpacity(0.5),
                          gradient: LinearGradient(
                            colors: [Colors.black, Colors.transparent],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 200,
                        left: 20,
                        child: SizedBox(
                          width: 150,
                          height: 400,
                          child: Image(
                            image: NetworkImage(
                              Constants.posterPrefix + movie.posterPath,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Flex(
                  direction: Axis.horizontal,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyMedium,
                            children: [
                              TextSpan(
                                text: movie.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                      color: Colors.amber,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Flex(
                  direction: Axis.horizontal,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyMedium,
                            children: [
                              TextSpan(
                                text: 'Average Rating: ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                        color: Colors.amber,
                                        fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text:
                                    '${(movie.rating / 2).toStringAsFixed(1)}/5',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Flex(
                  direction: Axis.horizontal,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyMedium,
                            children: [
                              TextSpan(
                                text: 'Synopsis: ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: Colors.amber,
                                    ),
                              ),
                              TextSpan(
                                text: movie.overview,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Flex(
                  direction: Axis.horizontal,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: IconTheme(
                          data: const IconThemeData(
                            color: Colors.amber,
                            size: 24,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                constraints:
                                    BoxConstraints.tight(const Size(600, 200)),
                                context: context,
                                builder: (context) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 16),
                                        child: Text(
                                          'Rate the Movie, Out of 5',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall,
                                        ),
                                      ),
                                      InteractiveRatingBar(ratings: ratings),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 16),
                                        child: GestureDetector(
                                          onTap: () {
                                            ref
                                                .read(ratingProvider.notifier)
                                                .state = 0;
                                          },
                                          child: Text(
                                            'clear',
                                            textAlign: TextAlign.right,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelLarge,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: RatingsBar(ratings: ratings),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                recommendation.when(
                  data: (movies) {
                    return MoviesList(
                      title:
                          'Recommendations \nBased on - ${movie.title.toUpperCase()}',
                      movies: movies,
                      axis: Axis.horizontal,
                    );
                  },
                  error: (error, stackTrace) => Center(
                    child: Text(
                      error.toString(),
                    ),
                  ),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      error: (e, st) => Scaffold(
        body: Center(
          child: Text(
            e.toString(),
          ),
        ),
      ),
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
