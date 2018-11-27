// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'duanzimodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DuanZiModel _$DuanZiModelFromJson(Map<String, dynamic> json) {
  return DuanZiModel(
      json['type'] as String,
      json['text'] as String,
      json['username'] as String,
      json['uid'] as String,
      json['header'] as String,
      json['up'] as int,
      json['down'] as int,
      json['thumbnail'] as String,
      json['video'] as String,
      json['image'] as String,
      json['comment'] as int,
      json['passtime'] as String);
}

Map<String, dynamic> _$DuanZiModelToJson(DuanZiModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'text': instance.text,
      'username': instance.username,
      'uid': instance.uid,
      'header': instance.header,
      'up': instance.up,
      'down': instance.down,
      'thumbnail': instance.thumbnail,
      'video': instance.video,
      'image': instance.image,
      'comment': instance.comment,
      'passtime': instance.passtime
    };
