import 'package:json_annotation/json_annotation.dart';
//将在我们运行生成命令后自动生成
part 'doubanmovemodel.g.dart';
//这个标注是告诉生成器，这个类是要生成Model类的
@JsonSerializable()
class DoubanModel {
  DoubanModel(this.rating, this.genres, this.title, this.casts, this.durations,this.directors, this.images);

  Rating rating;
  List<String> genres;
  String title;
  List<Avatar> casts;
  List<String> durations;
  List<Director> directors;
  Map<String,String> images;

  factory DoubanModel.fromJson(Map<String,dynamic> json) => _$DoubanModelFromJson(json);
}

@JsonSerializable()
class Rating {
  Rating(this.max,this.average);

  int max;
  double average;

  factory Rating.fromJson(Map<String,dynamic> json) => _$RatingFromJson(json);
}

@JsonSerializable()
class Avatar {
  Avatar(this.avatars,this.name_en,this.name,this.alt);
  Map<String,String> avatars;
  String name_en;
  String name;
  String alt;

  factory Avatar.fromJson(Map<String, dynamic> json) => _$AvatarFromJson(json);
}

@JsonSerializable()
class Director {
  @JsonKey(name: 'avatars')
  Map<String,String> icons;
  String name_en;
  String name;
  String alt;
  Director(this.icons,this.name_en,this.name,this.alt);

  factory Director.fromJson(Map<String, dynamic> json) => _$DirectorFromJson(json);
}

