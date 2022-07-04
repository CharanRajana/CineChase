// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:project32/extras/secret.dart';
import 'package:project32/widgets/trending_widget.dart';
import 'package:tmdb_api/tmdb_api.dart';

//import 'package:project32/extras/secret.dart';
//import 'package:tmdb_api/tmdb_api.dart';

class Description extends StatefulWidget {
  // ignore: non_constant_identifier_names;, prefer_typing_uninitialized_variables
  final int id;
  final String name;
  final String description;
  final String bannerurl;
  final String posterurl;
  final String vote;

  const Description({
    Key? key,
    required this.name,
    required this.description,
    required this.bannerurl,
    required this.posterurl,
    required this.vote,
    required this.id,
  }) : super(key: key);

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  List recomMovie = [];
  List recomTv = [];

  @override
  void initState() {
    load();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  load() async {
    TMDB tmdb = TMDB(
      ApiKeys(apiKey, readAccessToken),
      logConfig: const ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );

    //Map resultMovies = await tmdb.v3.movies.getSimilar(widget.id);
    Map resultTv = await tmdb.v3.tv.getRecommendations(widget.id);

    //recomMovie = resultMovies['results'];
    setState(() {
      recomTv = resultTv['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white10,
        child: const Icon(
          Icons.arrow_back_sharp,
          color: Colors.black,
          size: 50,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 500,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        widget.bannerurl,
                      ),
                      fit: BoxFit.cover,
                    ),
                    gradient: const LinearGradient(
                      colors: [Colors.black, Colors.transparent],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
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
                  top: 200,
                  left: 20,
                  child: SizedBox(
                    width: 150,
                    height: 400,
                    child: Image(
                      image: NetworkImage(
                        widget.posterurl,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Flex(
              direction: Axis.horizontal,
              children: [
                Flexible(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyText2,
                        children: [
                          TextSpan(
                            text: widget.name,
                            style:
                                Theme.of(context).textTheme.headline5?.copyWith(
                                      color: Colors.amber,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Flex(
              direction: Axis.horizontal,
              children: [
                Flexible(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyText2,
                        children: [
                          TextSpan(
                            text: 'Average Rating: ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(
                                    color: Colors.amber,
                                    fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: '${widget.vote}/10',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Flex(
              direction: Axis.horizontal,
              children: [
                Flexible(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyText2,
                        children: [
                          TextSpan(
                            text: 'Synopsis: ',
                            style:
                                Theme.of(context).textTheme.bodyText2?.copyWith(
                                      color: Colors.amber,
                                    ),
                          ),
                          TextSpan(
                            text: widget.description,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TrendingItems(
                trending: recomTv,
                title:
                    'Recommendations Based on - ${widget.name.toUpperCase()}'),
          ],
        ),
      ),
    );
  }
}
