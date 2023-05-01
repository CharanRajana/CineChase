import 'package:cinechase/src/data/movies_api_client/providers/movies_api_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinechase/src/presentation/screens/home_screen/components/horizontal_list_movies.dart';
import 'package:cinechase/src/presentation/screens/home_screen/components/search_bar.dart';
import '../../../core/assets.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final topMovies = ref.watch(topRatedMoviesProvider);
    final playingMovies = ref.watch(nowPlayingProvider);
    return Scaffold(
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 400,
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
                  return HorizontalMoviesList(
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
                  return HorizontalMoviesList(
                      title: 'Top Rated Movies', movies: movies);
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
