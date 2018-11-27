import 'package:json_annotation/json_annotation.dart';
part 'duanzimodel.g.dart';

@JsonSerializable()
class DuanZiModel {
  DuanZiModel(this.type,this.text,this.username,this.uid,this.header,this.up,this.down,this.thumbnail,this.video,this.image,this.comment,this.passtime);

  String type;
  String text;
  String username;
  String uid;
  String header;
  int up;
  int down;
  String thumbnail;
  String video;
  String image;
  int comment;
  String passtime;

  factory DuanZiModel.fromJson(Map<String,dynamic> json) => _$DuanZiModelFromJson(json);
}