import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;

import '../../view/movie_class.dart';
part 'popularmovie_event.dart';
part 'popularmovie_state.dart';
class PopularmovieBloc extends Bloc<PopularmovieEvent, PopularmovieState> {
  PopularmovieBloc() : super(PopularmovieInitial()) {
    on<PopularmovieEvent>((event, emit) async {
      // TODO: implement event handler
      
     if (event is FetchPopularMovieEvent) {
      emit (PopularMovieLoadingState());

      try {
     
        final response = await http.get(Uri.parse(
            "https://api.themoviedb.org/3/movie/top_rated?api_key=b22017b1058139fa43cc414290e9cfb5"));

        if (response.statusCode == 200) {

          final data = jsonDecode(response.body);
   
    final movieList = (data['results'] as List<dynamic>)
        .map((item) => Movie.fromJson(item))
        .toList();
        
        emit(PopularMovieLoadedState(data: movieList));
        } else {
          emit (PopularMovieErrorState("Failed to load the daa"));
        }
      } catch (e) {
        emit ( PopularMovieErrorState(e.toString()));
      }
    }
    });
  }
}
