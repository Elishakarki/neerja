import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:neerja/todo/database_helper.dart';

import '../view/movie_class.dart';

class TodoPage extends StatefulWidget {
  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  List<Movie> savedMovies = [];
  List<bool> isEditingList = [];

  @override
  void initState() {
    super.initState();
    loadSavedMovies();
  }

  Future<void> loadSavedMovies() async {
    final dbHelper = MovieDatabaseHelper();
    final movies = await dbHelper.getAllMovies();
    setState(() {
      savedMovies = movies;
      isEditingList = List.generate(movies.length, (index) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Movies'),
      ),
      body: savedMovies.isEmpty
          ? const Center(child: Text("No movies are Saved"))
          : ListView.builder(
              itemCount: savedMovies.length,
              itemBuilder: (context, index) {
                final movie = savedMovies[index];
                final titleController =
                    TextEditingController(text: movie.title);
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: Card(
                    elevation: 2,
                    shadowColor: Colors.grey[500],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: ListTile(
                      title: Row(
                        children: [
                          Expanded(
                            child: isEditingList[index]
                                ? TextFormField(
                                    controller: titleController,
                                    onSaved: (newValue) {
                                      setState(() {
                                        movie.title = newValue!;
                                      });
                                    },
                                  )
                                : Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(movie.title)),
                          ),
                          if (isEditingList[index])
                            IconButton(
                              onPressed: () async {
                                final dbHelper = MovieDatabaseHelper();
                                await dbHelper.updateMovieTitle(
                                    movie.id!, titleController.text);
                                await loadSavedMovies();
                                setState(() {
                                  isEditingList[index] = false;
                                });
                              },
                              icon: Icon(Icons.save),
                            ),
                        ],
                      ),
                      trailing: IntrinsicWidth(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () async {
                                final dbHelper = MovieDatabaseHelper();
                                await dbHelper.deleteMovie(movie.id!);
                                await loadSavedMovies();
                              },
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  isEditingList[index] = true;
                                });
                              },
                              icon: Icon(Icons.edit),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
