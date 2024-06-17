import 'package:bloc/bloc.dart';
import 'package:bloc_mvc/bloc/movies/bloc/movies_event.dart';
import 'package:bloc_mvc/bloc/movies/bloc/movies_state.dart';
import 'package:bloc_mvc/data/response/response.dart';
import 'package:bloc_mvc/repository/movies/movies_repository.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  MoviesRepository moviesRepository;
  MoviesBloc({required this.moviesRepository})
      : super(MoviesState(movieList: ApiResponse.loading())) {
    on<MovieFetched>(_onMovieFetched);
  }

  void _onMovieFetched(MovieFetched event, Emitter<MoviesState> emit) async {
    await moviesRepository.fetchMovieList().then((value) {
      emit(state.copyWith(movieList: ApiResponse.completed(value)));
    }).onError(
      (error, stackTrace) {
        emit(state.copyWith(movieList: ApiResponse.error(error.toString())));
      },
    );
  }
}
