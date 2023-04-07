import 'api_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../src/core/extras/constants.dart';
import 'models/models.dart';

final apiClientProvider = Provider<MoviesApiClient>(
    (ref) => MoviesApiClient(apiKey: Constants.apiKey));

final movieDetailsProvider = FutureProvider.autoDispose.family<Movie, int>(
    (ref, id) => ref.read(apiClientProvider).fetchMovieDetails(id));

final topRatedMoviesProvider = FutureProvider.autoDispose<List<Movie>>(
    (ref) => ref.read(apiClientProvider).fetchTopRatedMovies());

final nowPlayingProvider = FutureProvider.autoDispose<List<Movie>>(
    (ref) => ref.read(apiClientProvider).fetchNowPlayingMovies());

final recommendedMoviesProvider = FutureProvider.autoDispose
    .family<List<Movie>, int>(
        (ref, id) => ref.read(apiClientProvider).fetchRecommendations(id));

final fetchMoviesProvider = FutureProvider.autoDispose
    .family<List<Movie>, String>(
        (ref, query) => ref.read(apiClientProvider).fetchMovies(query));
