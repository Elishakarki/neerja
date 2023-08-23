part of 'popularmovie_bloc.dart';

abstract class PopularmovieState extends Equatable {
  const PopularmovieState();
  
  @override
  List<Object> get props => [];
}

final class PopularmovieInitial extends PopularmovieState {}
class PopularMovieLoadingState extends PopularmovieState{}
class PopularMovieLoadedState extends PopularmovieState{
final List<Movie> data ;
 PopularMovieLoadedState({required this.data});

      factory PopularMovieLoadedState.fromJson(List<dynamic> json) {
    List<Movie> movies = json.map((item) => Movie.fromJson(item)).toList();
    return PopularMovieLoadedState(data: movies);

  }

}


class PopularMovieErrorState extends PopularmovieState{
  String ? errormessage;
PopularMovieErrorState(this.errormessage);
}