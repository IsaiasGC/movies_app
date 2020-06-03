import 'package:dio/dio.dart';
import 'DBProvider.dart';
import 'Movie.dart';

class ApiProvider {

  Future<List<Movie>> getAllPopular() async {
    var url = "https://api.themoviedb.org/3/movie/popular?api_key=323f74918f363cfd35a67d3ea4a5316d&language=es-MX&page=1";
    Response response = await Dio().get(url);
    await DBProvider.db.deleteAllPopular();
    return (response.data['results'] as List).map((movie) {
      DBProvider.db.createPopular(Movie.fromJson(movie));
    }).toList();
  }

  Future<List<Movie>> getAllFavorite() async {
    var url = "https://api.themoviedb.org/3/list/143905?api_key=323f74918f363cfd35a67d3ea4a5316d&language=es-MX";
    Response response = await Dio().get(url);
    await DBProvider.db.deleteAllFavorite();
    return (response.data['items'] as List).map((movie) {
      DBProvider.db.createFavorite(Movie.fromJson(movie));
    }).toList();
  }
}