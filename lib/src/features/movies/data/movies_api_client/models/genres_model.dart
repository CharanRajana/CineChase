import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'genres_model.g.dart';

@JsonSerializable()
class Genre extends Equatable {
  @JsonKey(defaultValue: '')
  final String name;
  final int id;

  const Genre({
    this.name = '',
    this.id = 0,
  });

  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);

  @override
  List<Object?> get props => [name, id];
}
