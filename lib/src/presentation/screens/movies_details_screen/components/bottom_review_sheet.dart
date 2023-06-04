import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'interactive_rating_bar.dart';

Future<dynamic> bottomReviewSheet(
    BuildContext context, double ratings, int movieId, WidgetRef ref) {
  return showModalBottomSheet(
    constraints: BoxConstraints.tight(const Size(600, 180)),
    context: context,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Rate the Movie, Out of 5',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            InteractiveRatingBar(
              ratings: ratings,
              movieId: movieId,
            ),
          ],
        ),
      );
    },
  );
}
