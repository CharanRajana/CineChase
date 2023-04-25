import 'package:cinechase/src/presentation/screens/search_screen/search_screen.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      width: size.width * 0.7,
      child: InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const SearchScreen(),
          ),
        ),
        child: Hero(
          tag: 'search',
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(80),
            ),
            child: ListTile(
              visualDensity: VisualDensity.comfortable,
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
        ),
      ),
    );
  }
}
