import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neerja/main.dart';
import 'package:neerja/moviebloc/bloc/movie_bloc_bloc.dart';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

import '../todo/todo_view.dart';
import '../utility/shared_preferences.dart';
import 'movie_class.dart';
import 'movie_description.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final url =
      "https://api.themoviedb.org/3/movie/popular?api_key=b22017b1058139fa43cc414290e9cfb5";
  final String? firstname = UserSimplePreferences.getFirstname();
  final String? lastname = UserSimplePreferences.getLastname();
  final String? profileUrl = UserSimplePreferences.getProfileUrl();
  MovieBlocBloc movieBlocBloc = MovieBlocBloc();
  List<Movie> movies = [];
  Future<void> clearSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  @override
  void initState() {
    super.initState();
    movieBlocBloc.add(FetchMovieEvent());
  }

  @override
  Widget build(BuildContext context) {
    RouteSettings? currentRouteSettings = ModalRoute.of(context)?.settings;
    log(UserSimplePreferences.getFirstname().toString());
    return Scaffold(
        key: navigatorKey,
        drawer: Drawer(
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            Expanded(
              child: ListView(
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    accountName: Text(
                      UserSimplePreferences.getFirstname() ??
                          'Default Firstname',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    accountEmail: Text(
                      UserSimplePreferences.getLastname() ?? 'Default Lastname',
                    ),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: NetworkImage(
                        UserSimplePreferences.getProfileUrl() ?? '',
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('Home'),
                    onTap: () {
                      // Handle navigation to Home
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('Home'),
                    onTap: () {
                      // Handle navigation to Home
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('Home'),
                    onTap: () {
                      // Handle navigation to Home
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('Home'),
                    onTap: () {
                      // Handle navigation to Home
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('Home'),
                    onTap: () {
                      // Handle navigation to Home
                    },
                  ),
                  // Padding(
                  //   padding: EdgeInsets.all(20),
                  //   child: ElevatedButton(onPressed: (){
                  //     Navigator.pop(context);
                  //       clearSharedPreferences();

                  //   }, child: Text("Logout")),
                  // ),

                  //        ElevatedButton(
                  //          onPressed: () {
                  //            clearSharedPreferences();
                  //            Navigator.pop(context);
                  //          },
                  //          style: ButtonStyle(
                  //            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  //                const EdgeInsets.all(20)),
                  //            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  //              (Set<MaterialState> states) {
                  //                if (states.contains(MaterialState.dragged)) {
                  //                  return Colors.red;
                  //                }
                  //                if (states.contains(MaterialState.selected)) {
                  //                  return Colors.black;
                  //                }
                  //                return Colors.green;
                  //              },
                  //            ),
                  //            //  backgroundColor: MaterialStateProperty.all<Color>(Colors.green), // Background color
                  //            foregroundColor: MaterialStateProperty.all<Color>(
                  //                Colors.white), // Text color
                  //            elevation: MaterialStateProperty.all<double>(05), // Elevation
                  //            textStyle: MaterialStateProperty.all<TextStyle>(
                  //              const TextStyle(
                  //                  fontSize: 16, fontWeight: FontWeight.bold), // Text style
                  //            ),
                  //            shape: MaterialStateProperty.all<OutlinedBorder>(
                  //              RoundedRectangleBorder(
                  //                  borderRadius: BorderRadius.circular(10)), // Button shape
                  //            ),
                  //          ),
                  //          child: const Text("LogOut"),
                  //        )

                  // Add more ListTile items for navigation
                ],
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: OutlinedButton(
                    onPressed: () async {
                      await clearSharedPreferences();

                      Navigator.popUntil(context, ModalRoute.withName('/'));

                      //  exit(0) ;
                      //
                    },
                    child: Text("LogOut")),
              ),
            ),
          ]),
        ),
        appBar: AppBar(
            leading: Builder(builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            }),
            title: const Text("Popular Movies"),
            titleSpacing: 00.0,
            centerTitle: true,
            toolbarHeight: 120,
            toolbarOpacity: 0.8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 5,
            backgroundColor: Colors.green,
            shadowColor: Colors.grey,
            actions: <Widget>[
              PopupMenuButton<int>(
                onSelected: (value) {
                  if (value == 0) {}
                  if (value == 1) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>TodoPage()));
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem<int>(
                    value: 0,
                    child: ListTile(
                      leading: Icon(Icons.search),
                      title: Text("Saved Movies"),
                    ),
                  ),
                  const PopupMenuItem<int>(
                      value: 1,
                      child: ListTile(
                        leading: Icon(Icons.today_outlined),
                        title: Text(" Todo"),
                      )),
                ],
              ),
            ]),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              showModalBottomSheet(
                  isScrollControlled: false,
                  isDismissible: false,
                  elevation: 4,
                  backgroundColor: Colors.grey,
             
                  context: context,
                  builder: (context) {
                    return Container(
                      decoration: const BoxDecoration(
                          color: Colors.transparent,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(50))),
                      height: 600,
                      child: const Column(
                        children: [],
                      ),
                    );
                  });
            }),
        body: BlocConsumer<MovieBlocBloc, MovieBlocState>(
          bloc: movieBlocBloc,
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is MovieBlocLoadedState) {
              movies = state.data;
              return Padding(
                padding: const EdgeInsets.all(20),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                    // Number of columns in the grid
                  ),
                  itemBuilder: (context, index) {
                    final movie = movies[index];
                    log(movie.toString());
                    return MovieCard(movie: movie);
                  },
                  itemCount: movies.length,
                ),
              );
            } else if (state is MovieErrorState) {
              return Center(
                child: Text("Error:${state.error}"),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MovieDetailsScreen(
                      movie: movie,
                    )));
      },
      child: Card(
        elevation: 4.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 6,
              child: Image.network(
                'https://image.tmdb.org/t/p/w185${movie.posterPath}',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'Release Date: ${movie.releaseDate}',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Example usage:
