import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchCard extends StatelessWidget {
  const SearchCard({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: size.width * 0.7,
      child: GestureDetector(
        onTap: () => context.pushNamed('search'),
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
      ),
    );
  }
}
