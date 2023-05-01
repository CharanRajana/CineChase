import 'package:cinechase/src/data/movies_api_client/providers/movies_api_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'components/search_view.dart';
import 'components/vertical_list_card.dart';

final searchTextEditingControllerProvider =
    Provider.autoDispose<TextEditingController>(
        (ref) => TextEditingController());
final searchTextProvider = StateProvider<String>(
    (ref) => ref.read(searchTextEditingControllerProvider).text);

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends ConsumerState<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final searchController = ref.watch(searchTextEditingControllerProvider);
    final searchText = ref.watch(searchTextProvider);
    final searchResults = ref.watch(fetchMoviesProvider(searchText));
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: SearchView(
              controller: searchController, controllerText: searchText),
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
