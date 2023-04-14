import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:project32/src/presentation/screens/search_screen/search_screen.dart';

class SearchCard extends StatelessWidget {
  const SearchCard({
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
          height: 60,
          width: size.width * 0.7,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(80),
            ),
            child: ListTile(
              minLeadingWidth: 10,
              leading: const Padding(
                padding: EdgeInsets.only(top: 3),
                child: Icon(
                  Icons.search,
                ),
              ),
              title: Text(
                'Search for Movie Recommendations',
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
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
