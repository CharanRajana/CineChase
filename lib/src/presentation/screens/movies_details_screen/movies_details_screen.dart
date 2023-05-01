import 'package:cinechase/src/data/movies_api_client/providers/movies_api_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../../core/constants.dart';
import '../../../core/global_provider.dart';
import 'components/bottom_review_sheet.dart';
import 'components/ratings_bar.dart';
import 'components/sliding_up_grid_view.dart';

class MovieDetailsScreen extends ConsumerStatefulWidget {
  const MovieDetailsScreen({
    super.key,
    required this.id,
  });

  final int id;

  @override
  MovieDetailsScreenState createState() => MovieDetailsScreenState();
}

class MovieDetailsScreenState extends ConsumerState<MovieDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final movie = ref.watch(movieDetailsProvider(widget.id));
    final ratings = ref.watch(ratingProvider);
    final isFavourite = ref.watch(isFavouriteProvider);
    final recommendation = ref.watch(recommendedMoviesProvider(widget.id));
    return movie.when(
      data: (movie) {
        return Scaffold(
          body: SlidingUpPanel(
            backdropEnabled: true,
            parallaxEnabled: true,
            collapsed: collapsedView(context),
            borderRadius: BorderRadius.circular(30),
            minHeight: 60,
            maxHeight: height * .8,
            panelBuilder: (sc) =>
                slidingUpGridView(context, recommendation, sc),
            body: SafeArea(
              top: false,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 650,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                Constants.bgPrefix + movie.backdropPath,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.black, Colors.transparent],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: InkWell(
                              onTap: () => Navigator.of(context).pop(),
                              child: const CircleAvatar(
                                child: Icon(
                                  Icons.arrow_back_rounded,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 300,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: SizedBox(
                                  width: 150,
                                  height: 400,
                                  child: Hero(
                                    tag: movie.id.toString(),
                                    child: Image(
                                      image: NetworkImage(
                                        Constants.posterPrefix +
                                            movie.posterPath,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      movie.title,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Average Rating:  ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall
                                                ?.copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                          TextSpan(
                                            text: (movie.voteAverage! / 2)
                                                .toStringAsFixed(1),
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                          const WidgetSpan(
                                            child: Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                              size: 18,
                                            ),
                                          ),
                                          TextSpan(
                                            text: '/5',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    IconTheme(
                                      data: IconThemeData(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        size: 24,
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          bottomReviewSheet(
                                              context, ratings, ref);
                                        },
                                        child: RatingsBar(ratings: ratings),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        ref
                                            .read(isFavouriteProvider.notifier)
                                            .state = !isFavourite;
                                      },
                                      child: !isFavourite
                                          ? const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 8.0),
                                              child: Icon(
                                                Icons.bookmark,
                                                size: 20,
                                                color: Colors.amber,
                                              ),
                                            )
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8.0),
                                              child: Icon(
                                                Icons.bookmark_outline,
                                                size: 20,
                                                color: Colors.grey.shade600,
                                              ),
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
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
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                            ),
                            TextSpan(
                              text: movie.overview,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 150,
                    ),
                  ],
                ),
              ),
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
