import 'dart:convert';
import 'dart:developer';


import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart'as http;

import '../../view/movie_class.dart';
part 'movie_bloc_event.dart';
part 'movie_bloc_state.dart';

class MovieBlocBloc extends Bloc<MovieBlocEvent, MovieBlocState> {
  MovieBlocBloc() : super(MovieBlocInitial()) {
    on<MovieBlocEvent>((event, emit) async {
    
      
     if (event is FetchMovieEvent) {
      emit (MovieBlocLoadingState());

      try {
     
        final response = await http.get(Uri.parse(
            "https://api.themoviedb.org/3/movie/popular?api_key=b22017b1058139fa43cc414290e9cfb5"));

        if (response.statusCode == 200) {

          final data = jsonDecode(response.body);
   
    final movieList = (data['results'] as List<dynamic>)
        .map((item) => Movie.fromJson(item))
        .toList();
        
        emit(MovieBlocLoadedState(data: movieList));
        } else {
          emit (MovieErrorState("Failed to load the daa"));
        }
      } catch (e) {
        emit ( MovieErrorState(e.toString()));
      }
    }

 // TODO: implement event handler
      
    });
  }
}
