import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../search_screen.dart';

class SearchView extends ConsumerWidget {
  const SearchView({
    super.key,
    required this.controller,
    required this.controllerText,
  });

  final TextEditingController controller;
  final String controllerText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Hero(
      tag: 'search',
      child: Material(
        type: MaterialType.transparency,
        child: TextField(
          controller: controller,
          autofocus: true,
          onSubmitted: (value) {
            ref.read(searchTextProvider.notifier).state = value;
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Theme.of(context).colorScheme.surfaceVariant,
            hintText: 'Search for Movie Recommendations',
            hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            suffixIcon: controllerText.isEmpty
                ? null
                : IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    onPressed: () {
                      ref.read(searchTextProvider.notifier).state = "";
                      controller.clear(); //clear TextField
                    },
                  ),
            border: InputBorder.none,
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}
