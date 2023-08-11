

import '../models/trending_movies_response_model.dart';
import '../services/client/base_client.dart';

abstract class TrendingMoviesRepo {
  Future<TrendingMoviesResponse> getTrendingMoviesResponse([int page = 1]);
}

class HttpTrendingMoviesRepo implements TrendingMoviesRepo {
  @override
  Future<TrendingMoviesResponse> getTrendingMoviesResponse([int page = 1]) async {
    TrendingMoviesResponse trendingMoviesResponse;
    final String uri = '/trending/movie/day?language=en-US&page=${page.toString()}';
    final Map<String, dynamic> response = await BaseClient().get(uri);
    trendingMoviesResponse = TrendingMoviesResponse.fromJson(response);
    return trendingMoviesResponse;
  }
}