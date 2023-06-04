import 'package:cinechase/src/common/async_value_widget.dart';
import 'package:cinechase/src/repository/movies_api_client/models/movies_model.dart';
import 'package:cinechase/src/repository/movies_api_client/providers/movies_api_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinechase/src/presentation/screens/discover_screen/components/horizontal_list_movies.dart';
import 'package:cinechase/src/presentation/screens/discover_screen/components/search_bar.dart';
import '../../../constants/assets.dart';

class DiscoverScreen extends ConsumerWidget {
  const DiscoverScreen({super.key});
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
                    child: CustomSearchBar(size: size),
                  ),
                ],
              ),
              SizedBox(
                height: 400,
                child: AsyncValueWidget(
                  value: playingMovies,
                  data: (List<Movie> movies) {
                    return HorizontalMoviesList(
                      title: 'Now Playing Movies',
                      movies: movies,
                    );
                  },
                ),
              ),
              SizedBox(
                height: 400,
                child: AsyncValueWidget(
                  value: topMovies,
                  data: (List<Movie> movies) {
                    return HorizontalMoviesList(
                      title: 'Top Rated Movies',
                      movies: movies,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
