import 'package:cinechase/src/ui/components/popup_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinechase/src/ui/components/horizontal_list_movies.dart';
import 'package:cinechase/src/ui/screens/home_screen/components/search_bar.dart';
import '../../../core/assets.dart';
import '../../../core/providers.dart';

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
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: InkWell(
                        onTap: () {
                          showPopUpMenu(context);
                        },
                        child: const CircleAvatar(
                          child: Icon(
                            Icons.menu_rounded,
                          ),
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
