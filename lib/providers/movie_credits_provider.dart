import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/movie_credits_response_model.dart';
import '../repositories/movie_credits_repo.dart';

final movieCreditsRepoProvider = Provider<MovieCreditsRepo>((ref) {
  return HttpMovieCredits();
});

final movieCreditsProvider = FutureProvider.autoDispose
    .family<MovieCreditsResponse, int>((ref, id) async {
  final movieCreditsRepo = ref.watch(movieCreditsRepoProvider);
  return movieCreditsRepo.getMovieCredits(id);
});
