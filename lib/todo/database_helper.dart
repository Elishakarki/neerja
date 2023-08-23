import 'dart:developer';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../view/movie_class.dart';

class MovieDatabaseHelper {
  static final MovieDatabaseHelper _instance = MovieDatabaseHelper._();

  factory MovieDatabaseHelper() => _instance;

  MovieDatabaseHelper._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await init();
    return _database!;
  }

  Future<Database> init() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'movie_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE movies(
            id INTEGER PRIMARY KEY,
            releaseDate TEXT,
            title TEXT,
            posterPath TEXT,
            overview TEXT,
            voteCount INTEGER
          )
        ''');
      },
    );
  }

  Future<void> insertMovie(Movie movie) async {
    final db = await database;

    // Check if the movie with the same title already exists in the database
    final List<Map<String, dynamic>> existingMovies = await db.query(
      'movies',
      where: 'title = ?',
      whereArgs: [movie.title],
    );

    if (existingMovies.isNotEmpty) {
      // Movie with the same title already exists in the database
      // You can log a message or perform any other action here
      Fluttertoast.showToast(
          msg: "Movie '${movie.title}' is already saved in the database");
    } else {
      // Movie with the same title does not exist, perform the insert
      await db.insert(
        'movies',
        movie.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      // Log a success message
      Fluttertoast.showToast(
          msg: "Movie '${movie.title}' added to the database successfully");
    }
  }

  // Future<List<Movie>> getAllMovies() async {
  //   final db = await database;
  //   final List<Map<String, dynamic>> maps = await db.query('movies');

  //   Set<Movie> savedMoviesadd = {};

  //   for (final map in maps) {
  //     log(maps.toString());
  //     savedMoviesadd.add(Movie(
  //       id:map["id"],
  //       releaseDate: map['releaseDate'],
  //       title: map['title'],
  //       posterPath: map['posterPath'],
  //       overview: map['overview'],
  //       votecount: map['voteCount'],
  //       isadded:true,
  //       // Assuming this field represents saved status
  //     ));
  //   }

  //   List<Movie> savedMovies = savedMoviesadd.toList();
  //   for (var movie in savedMovies) {
  //     log('Title: ${movie.title}');
  //     log('Release Date: ${movie.releaseDate}');
  //     log('Poster Path: ${movie.posterPath}');
  //     log('Overview: ${movie.overview}');
  //     log('Vote Count: ${movie.votecount}');
  //   }
  //   return savedMovies;
  // }
  Future<List<Movie>> getAllMovies() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('movies');

    Set<String> uniqueMovieTitles = {}; // Use a set to store unique titles
    List<Movie> savedMovies = [];

    for (final map in maps) {
      final String title = map['title'];

      // Check if the movie title is not already added to the set
      if (!uniqueMovieTitles.contains(title)) {
        uniqueMovieTitles.add(title); // Add title to the set
        savedMovies.add(Movie(
          id: map["id"],
          releaseDate: map['releaseDate'],
          title: title, // Use the title from the map
          posterPath: map['posterPath'],
          overview: map['overview'],
          votecount: map['voteCount'],
          isadded: true,
        ));
      }
    }

    for (var movie in savedMovies) {
      log('Title: ${movie.title}');
      log('Release Date: ${movie.releaseDate}');
      log('Poster Path: ${movie.posterPath}');
      log('Overview: ${movie.overview}');
      log('Vote Count: ${movie.votecount}');
    }

    return savedMovies;
  }

  Future<void> deleteMovie(int id) async {
    final db = await database;
    await db.delete('movies', where: 'id = ?', whereArgs: [id]);
    var map = await db.query("movies");
    log(map.toString());
  }




  Future<void> updateMovieTitle(int id, String newTitle) async {
  final db = await database;
  await db.update(
    'movies',
    {'title': newTitle},
    where: 'id = ?',
    whereArgs: [id],
  );
}

}
