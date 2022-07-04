// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';

import '../screens/description.dart';
//import 'package:project32/extras/secret.dart';

class TrendingItems extends StatelessWidget {
  const TrendingItems({Key? key, required this.trending, required this.title})
      : super(key: key);

  final String title;
  final List trending;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10.0),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          SizedBox(
            height: 320,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: trending.length,
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
                              id: trending[index]['id'],
                              name: trending[index]['original_name'],
                              bannerurl: 'https://image.tmdb.org/t/p/w500' +
                                  trending[index]['backdrop_path'],
                              posterurl: 'https://image.tmdb.org/t/p/w500' +
                                  trending[index]['poster_path'],
                              description: trending[index]['overview'],
                              vote: trending[index]['vote_average'].toString(),
                            ),
                          ),
                        );
                      },
                      child: GridTile(
                        footer: GridTileBar(
                          backgroundColor: Colors.black54,
                          title: Text(
                            !title.contains('Movies')
                                ? trending[index]['original_name']
                                : trending[index]['original_title'],
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.subtitle1?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.amber,
                                    ),
                          ),
                        ),
                        child: Image(
                          image: NetworkImage(
                            'https://image.tmdb.org/t/p/w500' +
                                trending[index]['poster_path'],
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
    );
  }
}
