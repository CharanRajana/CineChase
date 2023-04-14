import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extras/providers.dart';
import 'interactive_rating_bar.dart';

Future<dynamic> bottomReviewSheet(
    BuildContext context, double ratings, WidgetRef ref) {
  return showModalBottomSheet(
    constraints: BoxConstraints.tight(const Size(600, 180)),
    context: context,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Rate the Movie, Out of 5',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            InteractiveRatingBar(ratings: ratings),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: GestureDetector(
                onTap: () {
                  ref.read(ratingProvider.notifier).state = 0;
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'clear',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
