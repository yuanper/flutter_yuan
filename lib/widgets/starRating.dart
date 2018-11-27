import 'package:flutter/material.dart';

class StarRating extends StatelessWidget{
  final int starCount;
  final double rating;
  final double size;
  final Color color;

  StarRating({
    this.starCount = 5,
    this.rating = 0,
    this.size,
    this.color
  });

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: List.generate(this.starCount, (index) => buildStar(context,index)),
    );
  }

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if(index >= rating) {
      icon = new Icon(
        Icons.star_border,
        color: Theme.of(context).buttonColor,
        size: size,
      );
    }else if (index > rating - 1 && index < rating) {
      icon = new Icon(
        Icons.star_half,
        color: color ?? Theme.of(context).primaryColor,
        size: size,
      );
    } else {
      icon = new Icon(
        Icons.star,
        color: color ?? Theme.of(context).primaryColor,
        size: size,
      );
    }
    return new InkResponse(
      child: icon,
    );
  }
}