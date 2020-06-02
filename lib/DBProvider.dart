import 'dart:io';
import 'dart:math';
import 'package:path/path.dart';
import 'dart:developer';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'Movie.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    // If database exists, return database
    if (_database != null) return _database;

    // If database don't exists, create one
    _database = await initDB();

    return _database;
  }

  // Create the database and the Movie table
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'movie.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute('CREATE TABLE movie(''title TEXT,''date TEXT,''image TEXT'')');
        });
  }

  // Insert employee on database
  createMovie(Movie newMovie) async {
    await deleteAllMovies();
    final db = await database;
    final res = await db.insert('Movie', newMovie.toJson());

    return res;
  }

  // Delete all employees
  Future<int> deleteAllMovies() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Movie');

    return res;
  }

  Future<List<Movie>> getAllMovies() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Movie");
    List<Movie> list =
    res.isNotEmpty ? res.map((c) => Movie.fromJson(c)).toList() : [];

    return list;
  }
}