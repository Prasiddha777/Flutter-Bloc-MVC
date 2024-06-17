import 'package:bloc_mvc/model/movie/movie_model.dart';

abstract class MoviesRepository {
  Future<MovieModel> fetchMovieList();
}
