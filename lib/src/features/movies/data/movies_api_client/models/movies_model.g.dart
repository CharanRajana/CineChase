// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movies_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) => Movie(
      json['id'] as int,
      (json['genres'] as List<dynamic>?)
              ?.map((e) => Genre.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      json['adult'] as bool? ?? false,
      json['backdrop_path'] as String? ?? '',
      json['poster_path'] as String? ?? '',
      json['original_title'] as String,
      json['overview'] as String? ?? '',
      json['runtime'] as int? ?? 0,
      json['status'] as String? ?? 'released',
      (json['vote_average'] as num?)?.toDouble() ?? 0,
      json['tagline'] as String? ?? '',
    );

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'id': instance.id,
      'genres': instance.genres,
      'adult': instance.adult,
      'backdrop_path': instance.backdropPath,
      'poster_path': instance.posterPath,
      'original_title': instance.title,
      'overview': instance.overview,
      'runtime': instance.runtime,
      'status': instance.status,
      'vote_average': instance.rating,
      'tagline': instance.tagline,
    };
