import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project32/src/core/extras/assets.dart';
import 'package:project32/src/presentation/components/horizontal_list_movies.dart';
import 'package:project32/src/presentation/screens/home_screen/components/search_bar.dart';

import '../../../core/extras/providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final topMovies = ref.watch(topRatedMoviesProvider);
    final playingMovies = ref.watch(nowPlayingProvider);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
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
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CircleAvatar(
                        child: Icon(
                          Icons.menu_rounded,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 300,
                    left: size.width * 0.1,
                    right: size.width * 0.1,
                    child: SearchBar(size: size),
                  ),
                ],
              ),
              playingMovies.when(
                data: (movies) {
                  return MoviesList(
                      title: 'Now Playing Movies', movies: movies);
                },
                error: (error, stackTrace) => Center(
                  child: Text(
                    error.toString(),
                  ),
                ),
                loading: () => const SizedBox(),
              ),
              const SizedBox(
                height: 20,
              ),
              topMovies.when(
                data: (movies) {
                  return MoviesList(title: 'Top Rated Movies', movies: movies);
                },
                error: (error, stackTrace) => Center(
                  child: Text(
                    error.toString(),
                  ),
                ),
                loading: () => const Center(
                  child: SizedBox(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
