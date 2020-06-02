import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Movie{
  String image;
  String title;
  String date;
  Movie({this.image,this.title,this.date});
  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
   image: json["poster_path"],
   title: json["title"],
   date: json["release_date"]
  );
  Map<String, dynamic> toJson() =>{
    "image": image,
    "title": title,
    "date": date,
  };
}