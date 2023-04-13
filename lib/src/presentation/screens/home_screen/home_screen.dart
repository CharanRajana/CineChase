import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project32/src/core/extras/assets.dart';
import 'package:project32/src/presentation/components/horizontal_list_movies.dart';
import 'package:project32/src/presentation/screens/home_screen/components/search_card.dart';

import '../../../core/extras/providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final topMovies = ref.watch(topRatedMoviesProvider);
    final playingMovies = ref.watch(nowPlayingProvider);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            leading: const Icon(
              Icons.menu_rounded,
            ),
            expandedHeight: 500,
            flexibleSpace: FlexibleSpaceBar(
              expandedTitleScale: 1.2,
              titlePadding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 60,
              ),
              title: SearchCard(size: size),
              centerTitle: true,
              background: Container(
                height: 500,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    opacity: 0.5,
                    image: AssetImage(
                      Assets.bgImage,
                    ),
                  ),
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black, Colors.transparent],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
              ),
            ),
          ),
          playingMovies.when(
            data: (movies) {
              return SliverToBoxAdapter(
                child: MoviesList(title: 'Now Playing Movies', movies: movies),
              );
            },
            error: (error, stackTrace) => SliverToBoxAdapter(
              child: Center(
                child: Text(
                  error.toString(),
                ),
              ),
            ),
            loading: () => const SliverToBoxAdapter(
              child: Center(
                child: SizedBox(),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
            ),
          ),
          topMovies.when(
            data: (movies) {
              return SliverToBoxAdapter(
                child: MoviesList(title: 'Top Rated Movies', movies: movies),
              );
            },
            error: (error, stackTrace) => SliverToBoxAdapter(
              child: Center(
                child: Text(
                  error.toString(),
                ),
              ),
            ),
            loading: () => const SliverToBoxAdapter(
              child: Center(
                child: SizedBox(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
