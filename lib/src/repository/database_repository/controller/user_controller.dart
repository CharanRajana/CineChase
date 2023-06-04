import 'package:cinechase/src/repository/database_repository/models/user_model.dart';
import 'package:cinechase/src/repository/movies_api_client/models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

final userControllerProvider = StateNotifierProvider<UserController, UserModel>(
  (ref) => UserController(),
);

class UserController extends StateNotifier<UserModel> {
  UserController() : super(UserModel.empty);

  String get name => state.name;
  String get id => state.id;
  String get email => state.email;
  List<Movie> get watchlist => state.watchlist;
  Map<String, dynamic> get ratings => state.ratings;

  void updateWatchlist(Movie movie) {
    List<Movie> value = [...state.watchlist];
    state.watchlist.contains(movie)
        ? value.removeWhere((element) => element == movie)
        : value = value.append(movie) as List<Movie>;

    state = state.copyWith(watchlist: value);
  }

  void updateRatings(int movieId, double ratings) {
    Map<String, dynamic> value = {...state.ratings};
    value.containsKey(movieId.toString())
        ? value.removeWhere((key, value) => key == movieId.toString())
        : value[movieId.toString()] = ratings;
    state = state.copyWith(ratings: value);
  }

  void updateUserData({
    required String id,
    required String email,
  }) {
    state = state.copyWith(
      id: id,
      email: email,
      name: email.split('@').first,
    );
  }
}
