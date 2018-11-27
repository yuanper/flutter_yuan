// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'picmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PicModel _$PicModelFromJson(Map<String, dynamic> json) {
  return PicModel(json['createdAt'] as String, json['publishedAt'] as String,
      json['type'] as String, json['url'] as String);
}

Map<String, dynamic> _$PicModelToJson(PicModel instance) => <String, dynamic>{
      'createdAt': instance.createdAt,
      'publishedAt': instance.publishedAt,
      'type': instance.type,
      'url': instance.url
    };
