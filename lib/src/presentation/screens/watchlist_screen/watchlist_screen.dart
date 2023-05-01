import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WatchListScreen extends ConsumerWidget {
  const WatchListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watchListStore = ['nothing', 'how are you'];

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => watchListStore,
        child: const Icon(Icons.refresh_outlined),
      ),
      appBar: AppBar(
        title: Text(
          'WatchList',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: watchListStore.length,
        itemBuilder: (context, index) {
          for (final item in watchListStore) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(item),
              ),
            );
          }
          return null;
        },
      ),
    );
  }
}
