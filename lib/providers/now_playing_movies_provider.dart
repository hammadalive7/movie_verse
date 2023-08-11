
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/now_playing_movies_response_model.dart';
import '../repositories/now_playing_movies_repo.dart';

final popularMoviesRepoProvider = Provider<NowPlayingMoviesRepo>((ref) {
  return HttpNowPlayingMoviesRepo();
});

final nowPlayingMoviesProvider = FutureProvider.autoDispose
    .family<NowPlayingMoviesResponse, int>((ref, start) async {
  final nowPlayingMoviesRepo = ref.watch(popularMoviesRepoProvider);
  return nowPlayingMoviesRepo.getNowPlayingMoviesResponse(start);
});







