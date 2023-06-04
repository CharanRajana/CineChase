import 'package:cinechase/src/repository/database_repository/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'half_filled_icon.dart';

class InteractiveRatingBar extends ConsumerWidget {
  const InteractiveRatingBar({
    super.key,
    required this.ratings,
    required this.movieId,
  });

  final double ratings;
  final int movieId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RatingBar(
      itemSize: 30,
      glow: false,
      initialRating: ratings,
      direction: Axis.horizontal,
      itemCount: 5,
      ratingWidget: RatingWidget(
        full: const Icon(
          Icons.star,
          color: Colors.amber,
        ),
        half: const HalfFilledIcon(
          icon: Icons.star,
          color: Colors.amber,
        ),
        empty: const Icon(
          Icons.star_border,
          color: Colors.amber,
        ),
      ),
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      onRatingUpdate: (rating) {
        ref
            .read(userControllerProvider.notifier)
            .updateRatings(movieId, rating);
      },
    );
  }
}
