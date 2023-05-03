import 'package:cinechase/src/core/assets.dart';
import 'package:cinechase/src/core/constants.dart';
import 'package:cinechase/src/presentation/screens/movies_details_screen/movies_details_screen.dart';
import 'package:cinechase/src/repository/movies_api_client/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Container collapsedView(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.background,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.maximize),
        Text(
          "Recommendations",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ],
    ),
  );
}

Scaffold slidingUpGridView(BuildContext context,
    AsyncValue<List<Movie>> recommendation, ScrollController sc) {
  return Scaffold(
    appBar: AppBar(
      title: Text(
        'Recommendations',
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
    ),
    body: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: recommendation.when(
        data: (movies) {
          return GridView.builder(
            controller: sc,
            itemCount: movies.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
            ),
            itemBuilder: (context, index) {
              return SizedBox(
                child: InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetailsScreen(
                        id: movies[index].id,
                      ),
                    ),
                  ),
                  child: Hero(
                    tag: movies[index].id.toString(),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
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
                ),
              );
            },
          );
        },
        error: (error, stackTrace) => Center(
          child: Text(
            error.toString(),
          ),
        ),
        loading: () => const Center(
          child: SizedBox(),
        ),
      ),
    ),
  );
}
