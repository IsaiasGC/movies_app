import 'dart:io';
import 'package:path/path.dart';
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

  // Create the database and the Popular & Favorite table
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'movies_app.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute('CREATE TABLE Popular(id INTEGER PRIMARY KEY, title TEXT, release_date TEXT, backdrop_path TEXT, overview TEXT, media_type TEXT)');
          await db.execute('CREATE TABLE Favorite(id INTEGER PRIMARY KEY, title TEXT, release_date TEXT, backdrop_path TEXT, overview TEXT, media_type TEXT)');
        });
  }

  // Insert Popular on database
  createPopular(Movie newMovie) async {
    
    final db = await database;
    final res = await db.insert('Popular', newMovie.toJson());
    
    return res;
  }

  // Delete all Popular
  Future<int> deleteAllPopular() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Popular');
    
    return res;
  }

  //Get all Popular
  Future<List<Movie>> getAllPopular() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Popular");
    List<Movie> list = res.isNotEmpty ? res.map((c) => Movie.fromJson(c)).toList() : [];
    
    return list;
  }

  // Insert Favorite on database
  createFavorite(Movie newMovie) async {
    await deleteAllFavorite();
    final db = await database;
    final res = await db.insert('Favorite', newMovie.toJson());
    
    return res;
  }

  // Delete all Favorite
  Future<int> deleteAllFavorite() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Favorite');
    
    return res;
  }

  //Get all Favorite
  Future<List<Movie>> getAllFavorite() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Favorite");
    List<Movie> list = res.isNotEmpty ? res.map((c) => Movie.fromJson(c)).toList() : [];
    
    return list;
  }
}