import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/extras/providers.dart';
import 'half_filled_icon.dart';

class InteractiveRatingBar extends ConsumerWidget {
  const InteractiveRatingBar({
    super.key,
    required this.ratings,
  });

  final double ratings;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RatingBar(
      glow: false,
      initialRating: ratings,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      ratingWidget: RatingWidget(
        full: Icon(
          Icons.star,
          color: Theme.of(context).colorScheme.primary,
        ),
        half: HalfFilledIcon(
          icon: Icons.star,
          color: Theme.of(context).colorScheme.primary,
        ),
        empty: Icon(
          Icons.star_border,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      onRatingUpdate: (rating) {
        ref.read(ratingProvider.notifier).state = rating;
      },
    );
  }
}
