import 'dart:developer';

import 'package:dio/dio.dart';
import 'DBProvider.dart';
import 'Movie.dart';

class MovieApiProvider {
  Future<List<Movie>> getAllMovies() async {
    var url = "https://api.themoviedb.org/3/movie/popular?api_key=323f74918f363cfd35a67d3ea4a5316d&language=es-MX&page=1";
    Response response = await Dio().get(url);
//    log("${response.data['results']}");
    return (response.data['results'] as List).map((employee) {
//      print('Inserting $employee');
      DBProvider.db.createMovie(Movie.fromJson(employee));
    }).toList();
  }
}