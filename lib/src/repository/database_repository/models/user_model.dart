import 'package:cinechase/src/repository/movies_api_client/models/models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';

part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    @Default('') String name,
    @Default('') String email,
    @Default([]) List<Movie> watchlist,
    @Default({}) Map<String, dynamic> ratings,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  static const empty = UserModel(
    id: '',
  );
}
