part of 'popularmovie_bloc.dart';

abstract class PopularmovieEvent extends Equatable {
  const PopularmovieEvent();

  @override
  List<Object> get props => [];
}

 class FetchPopularMovieEvent extends PopularmovieEvent{}