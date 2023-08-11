
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/movie_model.dart';
import '../repositories/similar_movies_repo.dart';

final similarMoviesRepoProvider = Provider<SimilarMoviesRepo>((ref) {
  return HttpSimilarMoviesRepo();
});

final similarMoviesProvider =
    FutureProvider.autoDispose.family<List<Movie>, int>((ref, movieId) async {
  final similarMoviesRepo = ref.watch(similarMoviesRepoProvider);
  return similarMoviesRepo.getSimilarMovies(movieId);
});
