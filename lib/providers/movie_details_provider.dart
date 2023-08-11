import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/movie_model.dart';
import '../repositories/movie_details_repo.dart';

final movieDetailsRepoProvider = Provider<MovieDetailsRepo>((ref) {
  return HttpMovieDetails();
});

final movieDetailsProvider =
FutureProvider.autoDispose.family<Movie, int>((ref, id) async {
  final movieDetailRepo = ref.watch(movieDetailsRepoProvider);
  return movieDetailRepo.getMovieDetails(id);
});
