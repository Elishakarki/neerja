part of 'movie_bloc_bloc.dart';

abstract class MovieBlocState extends Equatable {
  const MovieBlocState();
  
  @override
  List<Object> get props => [];
}

 class MovieBlocInitial extends MovieBlocState {}
 class MovieBlocLoadingState extends  MovieBlocState{

 }
 class MovieBlocLoadedState extends MovieBlocState{
final List<Movie> data;

  MovieBlocLoadedState({required this.data});



   factory MovieBlocLoadedState.fromJson(List<dynamic> json) {
    List<Movie> movies = json.map((item) => Movie.fromJson(item)).toList();
    return MovieBlocLoadedState(data: movies);
  }
}
  

 class MovieErrorState extends MovieBlocState {
  final String error;

  MovieErrorState(this.error);
}












