import 'package:flutter/material.dart';

import '../../../../core/extras/asset_strings.dart';
import '../../../../core/extras/constants.dart';
import '../../../movies/data/movies_api_client/models/models.dart';
import '../../../movies/presentation/screens/movies_details.dart';

Padding verticalMoviesList(List<Movie> movies) {
  return Padding(
    padding: const EdgeInsets.only(left: 25, right: 25, top: 50),
    child: ListView.separated(
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return SizedBox(
          height: 250,
          child: GestureDetector(
            onTap: () => {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      MovieDetailsScreen(id: movies[index].id),
                ),
              ),
            },
            child: Card(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 150,
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
                                    color: Colors.amber,
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
                  )
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
