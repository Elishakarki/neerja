part of 'movie_bloc_bloc.dart';

abstract class MovieBlocEvent extends Equatable {
  const MovieBlocEvent();

  @override
  List<Object> get props => [];
   
}

class FetchMovieEvent extends MovieBlocEvent{
  
}


