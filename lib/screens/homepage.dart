// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:project32/screens/description.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:project32/extras/secret.dart';

import '../widgets/page_header.dart';
import '../widgets/trending_widget.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List trendingMovies = [];
  List trendingTv = [];

  @override
  void initState() {
    load();
    super.initState();
  }

  load() async {
    TMDB tmdb = TMDB(
      ApiKeys(apiKey, readAccessToken),
      logConfig: const ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );

    Map resultMovies = await tmdb.v3.movies.getPopular();
    Map resultTv = await tmdb.v3.tv.getPopular();

    setState(
      () {
        trendingMovies = resultMovies['results'];
        trendingTv = resultTv['results'];
      },
    );
  }

  @override
  void dispose() {
    load().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.white12,
        label: Text(
          'About',
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        icon: const Icon(
          Icons.info_outline,
          color: Colors.white,
          size: 20,
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/about');
        },
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const PageHeader(),
            Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10.0),
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            'Curently Trending Movies',
                            style:
                                Theme.of(context).textTheme.headline6?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ),
                        SizedBox(
                          height: 320,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: trendingMovies.length,
                            itemBuilder: ((context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: 220,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Description(
                                            id: trendingMovies[index]['id'],
                                            name: trendingMovies[index]
                                                ['original_title'],
                                            bannerurl:
                                                'https://image.tmdb.org/t/p/w500' +
                                                    trendingMovies[index]
                                                        ['backdrop_path'],
                                            posterurl:
                                                'https://image.tmdb.org/t/p/w500' +
                                                    trendingMovies[index]
                                                        ['poster_path'],
                                            description: trendingMovies[index]
                                                ['overview'],
                                            vote: trendingMovies[index]
                                                    ['vote_average']
                                                .toString(),
                                          ),
                                        ),
                                      );
                                    },
                                    child: GridTile(
                                      footer: GridTileBar(
                                        backgroundColor: Colors.black54,
                                        title: Text(
                                          trendingMovies[index]
                                              ['original_title'],
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1
                                              ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.amber,
                                              ),
                                        ),
                                      ),
                                      child: Image(
                                        image: NetworkImage(
                                          'https://image.tmdb.org/t/p/w500' +
                                              trendingMovies[index]
                                                  ['poster_path'],
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TrendingItems(
                    title: 'Currently Trending tv-Shows',
                    trending: trendingTv,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
