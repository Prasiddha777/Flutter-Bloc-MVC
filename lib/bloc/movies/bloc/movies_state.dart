import 'package:bloc_mvc/data/response/response.dart';
import 'package:bloc_mvc/model/movie/movie_model.dart';
import 'package:equatable/equatable.dart';

class MoviesState extends Equatable {
  final ApiResponse<MovieModel> movieList;
  const MoviesState({required this.movieList});

  MoviesState copyWith({ApiResponse<MovieModel>? movieList}) {
    return MoviesState(movieList: movieList ?? this.movieList);
  }

  @override
  List<Object> get props => [movieList];
}
