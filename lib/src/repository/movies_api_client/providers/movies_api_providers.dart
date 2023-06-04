import 'package:cinechase/src/constants/secrets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../api_client.dart';
import '../models/models.dart';

final apiClientProvider = Provider<MoviesApiClient>(
  (ref) => MoviesApiClient(
    apiKey: Secrets.movieApiKey,
  ),
);

final movieDetailsProvider = FutureProvider.autoDispose.family<Movie, int>(
  (ref, id) => ref.read(apiClientProvider).fetchMovieDetails(id),
);

final topRatedMoviesProvider = FutureProvider.autoDispose<List<Movie>>(
  (ref) => ref.read(apiClientProvider).fetchTopRatedMovies(),
);

final nowPlayingProvider = FutureProvider.autoDispose<List<Movie>>(
  (ref) => ref.read(apiClientProvider).fetchNowPlayingMovies(),
);

final recommendedMoviesProvider =
    FutureProvider.autoDispose.family<List<Movie>, int>(
  (ref, id) => ref.read(apiClientProvider).fetchRecommendations(id),
);

final fetchMoviesProvider =
    FutureProvider.autoDispose.family<List<Movie>, String>(
  (ref, input) => ref.read(apiClientProvider).fetchMovies(input),
);
