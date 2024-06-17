import 'package:bloc_mvc/data/network/network_api_services.dart';
import 'package:bloc_mvc/model/movie/movie_model.dart';
import 'package:bloc_mvc/repository/movies/movies_repository.dart';
import 'package:bloc_mvc/utils/app_urls.dart';

class MoviesHttpApiRepository implements MoviesRepository {
  final _apiServices = NetworkApiService();
  @override
  Future<MovieModel> fetchMovieList() async {
    final response = await _apiServices.getApi(AppUrl.popularMoviesListEndPoint);
    return MovieModel.fromJson(response);
  }
}
