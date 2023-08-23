import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../popularmovie/bloc/popularmovie_bloc.dart';
import '../todo/database_helper.dart';
import 'movie_class.dart';
import 'second_screen.dart';

class MovieDetailsScreen extends StatefulWidget {
  final Movie movie;

  const MovieDetailsScreen({Key? key, required this.movie}) : super(key: key);

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  PopularmovieBloc popularmovieBloc = PopularmovieBloc();
  @override
  void initState() {
    popularmovieBloc.add(FetchPopularMovieEvent());
    super.initState();
  }

  List<Movie>? popularmovie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie.title),
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              child: Image.network(
                'https://image.tmdb.org/t/p/w185${widget.movie.posterPath}',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Release Date: ${widget.movie.releaseDate}',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Voter Count: ${widget.movie.votecount}',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            SizedBox(height: 16),
            Text(
              '${widget.movie.overview}',
              style: TextStyle(fontSize: 18, color: Colors.black87),
              maxLines: 6,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 16),

            Row(children: [
              OutlinedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Colors.black)),
                  onPressed: () {},
                  child: Text(
                    "Top Rated",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
              IconButton(
                icon: Icon(Icons.save),
                onPressed: () async {
                  log("somethig");
                  final dbHelper = MovieDatabaseHelper();
                  await dbHelper.insertMovie(widget.movie);
                  

                  log("repeat");
                },
              ),
            ]),
            SizedBox(height: 16),
            BlocConsumer<PopularmovieBloc, PopularmovieState>(
                bloc: popularmovieBloc,
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  log(state.toString());
                  if (state is PopularMovieLoadingState) {
                    return CircularProgressIndicator();
                  }
                  if (state is PopularMovieLoadedState) {
                    popularmovie = state.data;
                    log(popularmovie.toString());
                    return Container(
                      height: MediaQuery.sizeOf(context).height * 0.25,
                      child: Expanded(
                        child: ListView.builder(
                            itemCount: popularmovie!.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              var movie = popularmovie![index];
                              log(movie.toString());
                              return Card(
                                elevation: 4.0,
                                child: Column(
                                  //crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 140,
                                      height: 120,
                                      child: Image.network(
                                        'https://image.tmdb.org/t/p/w185${movie.posterPath}',
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.26,
                                        child: Text(
                                          movie.title,
                                          style: const TextStyle(fontSize: 12),
                                          overflow: TextOverflow.visible,
                                          maxLines: 2,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Padding(
                                        padding: EdgeInsets.zero,
                                        child: Container(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.26,
                                            child: Text(
                                              "Release date: ${movie.releaseDate}",
                                              style: TextStyle(fontSize: 12),
                                              overflow: TextOverflow.visible,
                                            ))),
                                  ],
                                ),
                              );
                            }),
                      ),
                    );
                  }
                  return CircularProgressIndicator();
                })
            // You can add more details about the movie here
          ],
        ),
      ),
    );
  }
}
