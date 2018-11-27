// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doubanmovemodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoubanModel _$DoubanModelFromJson(Map<String, dynamic> json) {
  return DoubanModel(
      json['rating'] == null
          ? null
          : Rating.fromJson(json['rating'] as Map<String, dynamic>),
      (json['genres'] as List)?.map((e) => e as String)?.toList(),
      json['title'] as String,
      (json['casts'] as List)
          ?.map((e) =>
              e == null ? null : Avatar.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['durations'] as List)?.map((e) => e as String)?.toList(),
      (json['directors'] as List)
          ?.map((e) =>
              e == null ? null : Director.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['images'] as Map<String, dynamic>)
          ?.map((k, e) => MapEntry(k, e as String)));
}

Map<String, dynamic> _$DoubanModelToJson(DoubanModel instance) =>
    <String, dynamic>{
      'rating': instance.rating,
      'genres': instance.genres,
      'title': instance.title,
      'casts': instance.casts,
      'durations': instance.durations,
      'directors': instance.directors,
      'images': instance.images
    };

Rating _$RatingFromJson(Map<String, dynamic> json) {
  return Rating(json['max'] as int, (json['average'] as num)?.toDouble());
}

Map<String, dynamic> _$RatingToJson(Rating instance) =>
    <String, dynamic>{'max': instance.max, 'average': instance.average};

Avatar _$AvatarFromJson(Map<String, dynamic> json) {
  return Avatar(
      (json['avatars'] as Map<String, dynamic>)
          ?.map((k, e) => MapEntry(k, e as String)),
      json['name_en'] as String,
      json['name'] as String,
      json['alt'] as String);
}

Map<String, dynamic> _$AvatarToJson(Avatar instance) => <String, dynamic>{
      'avatars': instance.avatars,
      'name_en': instance.name_en,
      'name': instance.name,
      'alt': instance.alt
    };

Director _$DirectorFromJson(Map<String, dynamic> json) {
  return Director(
      (json['avatars'] as Map<String, dynamic>)
          ?.map((k, e) => MapEntry(k, e as String)),
      json['name_en'] as String,
      json['name'] as String,
      json['alt'] as String);
}

Map<String, dynamic> _$DirectorToJson(Director instance) => <String, dynamic>{
      'avatars': instance.icons,
      'name_en': instance.name_en,
      'name': instance.name,
      'alt': instance.alt
    };
