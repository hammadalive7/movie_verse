

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/trending_movies_response_model.dart';
import '../repositories/trending_movies_repo.dart';

final trendingMoviesRepoProvider = Provider<TrendingMoviesRepo>((ref) {
  return HttpTrendingMoviesRepo();
});

final trendingMoviesProvider = FutureProvider.autoDispose
    .family<TrendingMoviesResponse, int>((ref, start) async {
  final trendingMoviesRepo = ref.watch(trendingMoviesRepoProvider);
  return trendingMoviesRepo.getTrendingMoviesResponse(start);
});
