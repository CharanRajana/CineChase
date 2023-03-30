import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project32/src/core/extras/asset_strings.dart';
import 'package:project32/src/core/widgets/movies_list.dart';
import 'package:project32/src/features/search/presentation/screens/search_screen.dart';

import '../../../movies/data/movies_api_client/providers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                const SizedBox(
                  height: 500,
                  width: double.infinity,
                  child: Image(
                    fit: BoxFit.cover,
                    color: Color.fromRGBO(255, 255, 255, 0.5),
                    colorBlendMode: BlendMode.modulate,
                    image: AssetImage(
                      Assets.bgImage,
                    ),
                  ),
                ),
                Container(
                  height: 500,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    //color: Colors.white.withOpacity(0.5),
                    gradient: LinearGradient(
                      colors: [Colors.black, Colors.transparent],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
                Positioned(
                  top: 300,
                  right: size.width * 0.1,
                  left: size.width * 0.1,
                  child: SizedBox(
                    height: 60,
                    width: size.width * 0.7,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SearchScreen(),
                        ),
                      ),
                      child: Hero(
                        tag: 'search',
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80),
                          ),
                          child: ListTile(
                            minLeadingWidth: 10,
                            leading: const Padding(
                              padding: EdgeInsets.only(top: 3),
                              child: Icon(
                                Icons.search,
                              ),
                            ),
                            title: Text(
                              'Search for Movie Recommendations',
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.outline,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Consumer(
              builder: (context, ref, child) {
                final movie = ref.watch(nowPlayingProvider);
                return movie.when(
                  data: (movies) {
                    return MoviesList(
                      title: 'Now Playing Movies',
                      movies: movies,
                      axis: Axis.horizontal,
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
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Consumer(
              builder: (context, ref, child) {
                final movie = ref.watch(topRatedMoviesProvider);
                return movie.when(
                  data: (movies) {
                    return MoviesList(
                      title: 'Top Rated Movies',
                      movies: movies,
                      axis: Axis.horizontal,
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
