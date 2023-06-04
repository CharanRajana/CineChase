import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models/models.dart';

class MoviesApiClient {
  final String apiKey;
  String baseUrl = 'https://api.themoviedb.org';
  String api = 'http://0.0.0.0:8000/users/next_id';

  MoviesApiClient({required this.apiKey});

  Future<Movie> fetchMovieDetails(int id) async {
    final request =
        Uri.parse('$baseUrl/3/movie/$id?api_key=$apiKey&language=en-US');

    final response = await http.get(request);

    if (response.statusCode != 200) {}

    final responseJson = json.decode(response.body) as Map<String, dynamic>;

    if (responseJson.isEmpty) {}

    return Movie.fromJson(responseJson);
  }

  Future<List<Movie>> fetchTopRatedMovies() async {
    final request = Uri.parse(
        '$baseUrl/3/movie/top_rated?api_key=$apiKey&language=en-US&page=1');

    final response = await http.get(request);

    if (response.statusCode != 200) {}

    final responseJson = json.decode(response.body) as Map<String, dynamic>;

    if (!responseJson.containsKey('results')) {}

    final results = responseJson['results'] as List;

    if (results.isEmpty) {}

    return List<Movie>.from(results.map((e) => Movie.fromJson(e)));
  }

  Future<List<Movie>> fetchNowPlayingMovies() async {
    final request = Uri.parse(
        '$baseUrl/3/movie/now_playing?api_key=$apiKey&language=en-US&page=1');

    final response = await http.get(request);

    if (response.statusCode != 200) {}

    final responseJson = json.decode(response.body) as Map<String, dynamic>;

    if (!responseJson.containsKey('results')) {}

    final results = responseJson['results'] as List;

    if (results.isEmpty) {}

    return List<Movie>.from(results.map((e) => Movie.fromJson(e)));
  }

  Future<List<Movie>> fetchRecommendations(int id) async {
    final request = Uri.parse(
        '$baseUrl/3/movie/$id/recommendations?api_key=$apiKey&language=en-US&page=1');

    final response = await http.get(request);

    if (response.statusCode != 200) {}

    final responseJson = json.decode(response.body) as Map<String, dynamic>;

    if (!responseJson.containsKey('results')) {}

    final results = responseJson['results'] as List;

    if (results.isEmpty) {}

    return List<Movie>.from(results.map((e) => Movie.fromJson(e)));
  }

  Future<List<Movie>> fetchMovies(String input) async {
    final query = input.replaceAll(" ", "%20");
    final request = Uri.parse(
        '$baseUrl/3/search/movie?api_key=$apiKey&query=$query&include_adult=false&language=en-US&page=1');

    final response = await http.get(request);

    if (response.statusCode != 200) {}

    final responseJson = json.decode(response.body) as Map<String, dynamic>;

    if (!responseJson.containsKey('results')) {}

    final results = responseJson['results'] as List;

    if (results.isEmpty) {}

    return List<Movie>.from(results.map((e) => Movie.fromJson(e)));
  }
}
