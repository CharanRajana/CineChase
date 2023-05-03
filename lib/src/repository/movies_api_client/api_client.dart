import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../core/constants.dart';
import 'models/models.dart';

class MoviesApiClient {
  final String apiKey;

  MoviesApiClient({required this.apiKey});

  Future<Movie> fetchMovieDetails(int id) async {
    final request = Uri.https(Constants.baseUrl, '/3/movie/$id',
        {'api_key': apiKey, 'language': 'en-US'});

    final response = await http.get(request);

    if (response.statusCode != 200) {}

    final responseJson = json.decode(response.body) as Map<String, dynamic>;

    if (responseJson.isEmpty) {}

    return Movie.fromJson(responseJson);
  }

  Future<List<Movie>> fetchTopRatedMovies() async {
    final request = Uri.https(Constants.baseUrl, '/3/movie/top_rated',
        {'api_key': apiKey, 'language': 'en-US', 'page': '1'});

    final response = await http.get(request);

    if (response.statusCode != 200) {}

    final responseJson = json.decode(response.body) as Map<String, dynamic>;

    if (!responseJson.containsKey('results')) {}

    final results = responseJson['results'] as List;

    if (results.isEmpty) {}

    return List<Movie>.from(results.map((e) => Movie.fromJson(e)));
  }

  Future<List<Movie>> fetchNowPlayingMovies() async {
    final request = Uri.https(Constants.baseUrl, '/3/movie/now_playing',
        {'api_key': apiKey, 'language': 'en-US', 'page': '1'});

    final response = await http.get(request);

    if (response.statusCode != 200) {}

    final responseJson = json.decode(response.body) as Map<String, dynamic>;

    if (!responseJson.containsKey('results')) {}

    final results = responseJson['results'] as List;

    if (results.isEmpty) {}

    return List<Movie>.from(results.map((e) => Movie.fromJson(e)));
  }

  Future<List<Movie>> fetchRecommendations(int id) async {
    final request = Uri.https(Constants.baseUrl, '/3/movie/$id/recommendations',
        {'api_key': apiKey, 'language': 'en-US', 'page': '1'});

    final response = await http.get(request);

    if (response.statusCode != 200) {}

    final responseJson = json.decode(response.body) as Map<String, dynamic>;

    if (!responseJson.containsKey('results')) {}

    final results = responseJson['results'] as List;

    if (results.isEmpty) {}

    return List<Movie>.from(results.map((e) => Movie.fromJson(e)));
  }

  Future<List<Movie>> fetchMovies(String queryy) async {
    final query = queryy.replaceAll(" ", "+");
    final request = Uri.https(
      Constants.baseUrl,
      '/3/search/movie',
      {
        'api_key': apiKey,
        'language': 'en-US',
        'query': query,
        'page': '1',
        'include_adult': 'false'
      },
    );

    final response = await http.get(request);

    if (response.statusCode != 200) {}

    final responseJson = json.decode(response.body) as Map<String, dynamic>;

    if (!responseJson.containsKey('results')) {}

    final results = responseJson['results'] as List;

    if (results.isEmpty) {}

    return List<Movie>.from(results.map((e) => Movie.fromJson(e)));
  }
}
