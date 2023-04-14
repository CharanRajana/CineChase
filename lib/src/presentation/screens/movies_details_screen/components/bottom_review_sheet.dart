import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extras/providers.dart';
import 'interactive_rating_bar.dart';

Future<dynamic> bottomReviewSheet(
    BuildContext context, double ratings, WidgetRef ref) {
  return showModalBottomSheet(
    constraints: BoxConstraints.tight(const Size(600, 200)),
    context: context,
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Text(
              'Rate the Movie, Out of 5',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          InteractiveRatingBar(ratings: ratings),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: GestureDetector(
              onTap: () {
                ref.read(ratingProvider.notifier).state = 0;
              },
              child: Text(
                'clear',
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ),
        ],
      );
    },
  );
}
