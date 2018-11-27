import 'package:json_annotation/json_annotation.dart';
part 'picmodel.g.dart';

@JsonSerializable()
class PicModel {
  PicModel(this.createdAt,this.publishedAt,this.type,this.url);

  String createdAt;
  String publishedAt;
  String type;
  String url;

  factory PicModel.fromJson(Map<String,dynamic> json) => _$PicModelFromJson(json);
}