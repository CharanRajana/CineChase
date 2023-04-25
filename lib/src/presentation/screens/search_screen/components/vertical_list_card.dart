import 'package:flutter/material.dart';
import '../../../../core/assets.dart';
import '../../../../core/constants.dart';
import '../../../../data/movies_api_client/models/movies_model.dart';
import '../../movies_details_screen/movies_details_screen.dart';

Padding verticalMoviesList(List<Movie> movies) {
  return Padding(
    padding: const EdgeInsets.only(left: 25, right: 25, top: 50),
    child: ListView.separated(
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return SizedBox(
          height: 250,
          child: InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieDetailsScreen(
                  id: movies[index].id,
                ),
              ),
            ),
            child: Card(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 150,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Hero(
                          tag: movies[index].id.toString(),
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
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: DefaultTextStyle(
                        style: Theme.of(context).textTheme.bodyMedium!,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              movies[index].title,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                movies[index].overview,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.normal,
                                    ),
                                maxLines: 3,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 20,
        );
      },
      itemCount: movies.length,
    ),
  );
}
