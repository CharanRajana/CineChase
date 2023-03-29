import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'genres_model.dart';

part 'movies_model.g.dart';

@JsonSerializable()
class Movie extends Equatable {
  final int id;
  @JsonKey(defaultValue: [])
  final List<Genre> genres;
  @JsonKey(defaultValue: false)
  final bool adult;
  @JsonKey(defaultValue: '', name: 'backdrop_path')
  final String backdropPath;
  @JsonKey(defaultValue: '', name: 'poster_path')
  final String posterPath;
  @JsonKey(name: 'original_title')
  final String title;
  @JsonKey(defaultValue: '')
  final String overview;
  @JsonKey(defaultValue: 0)
  final int runtime;
  @JsonKey(defaultValue: 'released')
  final String status;
  @JsonKey(defaultValue: 0, name: 'vote_average')
  final double rating;
  @JsonKey(defaultValue: '')
  final String tagline;

  const Movie(
      this.id,
      this.genres,
      this.adult,
      this.backdropPath,
      this.posterPath,
      this.title,
      this.overview,
      this.runtime,
      this.status,
      this.rating,
      this.tagline);

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  @override
  String toString() {
    return 'Movie (id : $id, title : $title)';
  }

  @override
  List<Object?> get props => [title, id];
}
