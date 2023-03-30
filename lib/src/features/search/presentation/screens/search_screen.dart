import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project32/src/features/movies/data/movies_api_client/providers.dart';

import '../../../../core/extras/asset_strings.dart';
import '../../../../core/extras/constants.dart';
import '../../../movies/presentation/screens/movies_details.dart';

final textController = StateProvider.autoDispose<String>((ref) => "");

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    final controllerText = ref.watch(textController);
    final searchResults = ref.watch(fetchMoviesProvider(controllerText));
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: 'search',
          child: Material(
            child: TextField(
              controller: controller,
              autofocus: true,
              onSubmitted: (value) {
                debugPrint(value);
                ref.read(textController.notifier).state = value;
                debugPrint(ref.read(textController.notifier).state);
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Theme.of(context).colorScheme.surfaceVariant,
                hintText: 'Search for Movie Recommendations',
                hintStyle: Theme.of(context).textTheme.bodyLarge,
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(
                      Icons.arrow_back,
                    ),
                  ),
                ),
                suffixIcon: controllerText.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          ref.read(textController.notifier).state = "";
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
        ),
      ),
      body: searchResults.when(
        data: (items) {
          return SizedBox(
            width: 300,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  height: 450,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            MovieDetailsScreen(id: items[index].id),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridTile(
                            footer: GridTileBar(
                              backgroundColor: Colors.black54,
                              title: Text(
                                items[index].title,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.amber,
                                    ),
                              ),
                            ),
                            child: FadeInImage(
                              placeholder: const AssetImage(Assets.placeholder),
                              image: NetworkImage(Constants.posterPrefix +
                                  items[index].posterPath),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
        error: (error, stackTrace) => Center(
          child: Text(
            error.toString(),
          ),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
