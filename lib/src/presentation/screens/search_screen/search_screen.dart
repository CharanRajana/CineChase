import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/extras/providers.dart';
import 'components/search_view.dart';
import 'components/vertical_list_card.dart';

final textController = StateProvider.autoDispose<String>((ref) => "");

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    final controllerText = ref.watch(textController);
    final searchResults = ref.watch(fetchMoviesProvider(controllerText));
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: SearchView(
              controller: controller, controllerText: controllerText),
        ),
        body: searchResults.when(
          data: (movies) {
            return verticalMoviesList(movies);
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
      ),
    );
  }
}
