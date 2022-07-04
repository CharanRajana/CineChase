// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:project32/extras/secret.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../screens/description.dart';

class PageHeader extends StatefulWidget {
  const PageHeader({Key? key}) : super(key: key);

  @override
  State<PageHeader> createState() => _PageHeaderState();
}

class _PageHeaderState extends State<PageHeader> {
  TextEditingController searchController = TextEditingController();
  String input = '';
  List trending = [];

  @override
  void initState() {
    super.initState();
  }

  performJust(List<dynamic> list) {
    list[0]['media_type'] == null
        ? Navigator.pushNamed(context, '/404')
        : list[0]['backdrop_path'] == null
            ? Navigator.pushNamed(context, '/404')
            : list[0]['poster_path'] == null
                ? Navigator.pushNamed(context, '/404')
                : list[0]['overview'] == null
                    ? Navigator.pushNamed(context, '/404')
                    : list[0]['vote_average'] == null
                        ? Navigator.pushNamed(context, '/404')
                        : Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return Description(
                                  id: list[0]['id'],
                                  name: !list[0]['media_type'].contains('movie')
                                      ? list[0]['original_name']
                                      : list[0]['original_title'],
                                  bannerurl: 'https://image.tmdb.org/t/p/w500' +
                                      list[0]['backdrop_path'],
                                  posterurl: 'https://image.tmdb.org/t/p/w500' +
                                      list[0]['poster_path'],
                                  description: list[0]['overview'],
                                  vote: list[0]['vote_average'].toString(),
                                );
                              },
                            ),
                          );
  }

  TMDB tmdb = TMDB(
    ApiKeys(apiKey, readAccessToken),
    logConfig: const ConfigLogger(
      showLogs: true,
      showErrorLogs: true,
    ),
  );

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const SizedBox(
          height: 500,
          width: double.infinity,
          child: Image(
            fit: BoxFit.cover,
            color: Color.fromRGBO(255, 255, 255, 0.5),
            colorBlendMode: BlendMode.modulate,
            image: AssetImage(
              'assets/images/bg.jpg',
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
          left: MediaQuery.of(context).size.width * 0.1,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(8),
            ),
            height: 45,
            width: MediaQuery.of(context).size.width * 0.7,
            child: TextField(
              style: Theme.of(context).textTheme.button?.copyWith(
                    color: Colors.black,
                  ),
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Enter a movie or a tv-show',
                hintStyle: Theme.of(context).textTheme.button?.copyWith(
                      color: Colors.blueGrey,
                    ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      8,
                    ),
                  ),
                ),
                suffixIcon: InkWell(
                  onTap: () {
                    setState(
                      () {
                        searchController.clear();
                      },
                    );
                  },
                  child: const Icon(
                    Icons.clear,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 300,
          right: MediaQuery.of(context).size.width * 0.11,
          child: InkWell(
            onTap: () async {
              input = searchController.text;
              Map out = await tmdb.v3.search.queryMulti(input);
              trending = out['results'];
              performJust(trending);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(8),
              ),
              height: 45,
              width: MediaQuery.of(context).size.width * 0.08,
              child: const Icon(
                Icons.search_outlined,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
