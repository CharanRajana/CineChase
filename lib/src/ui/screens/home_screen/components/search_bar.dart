import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:cinechase/src/ui/screens/search_screen/search_screen.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedColor: Colors.transparent,
      openColor: Colors.transparent,
      closedBuilder: (context, action) {
        return SizedBox(
          height: 56,
          width: size.width * 0.7,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(80),
            ),
            child: ListTile(
              minLeadingWidth: 10,
              leading: Icon(
                Icons.search,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              title: Text(
                'Search for Movie Recommendations',
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            ),
          ),
        );
      },
      openBuilder: (context, action) {
        return const SearchScreen();
      },
    );
  }
}
