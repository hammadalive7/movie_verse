
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_verse/providers/page_number_providers.dart';

import '../models/movies_with_genres_response_model.dart';
import '../repositories/movies_with_genres_repo.dart';

final popularMoviesWithGenreRepoProvider =
    Provider<PopularMoviesWithGenresRepo>(
  (ref) {
    return HttpPopularMoviesWithGenre();
  },
);

final popularMoviesWithGenresProvider = FutureProvider.autoDispose
    .family<PopularMoviesWithGenresResponse, List<int>>(
  (ref, listOfGenres) async {
    final popularMoviesWithGenresRepo =
        ref.watch(popularMoviesWithGenreRepoProvider);
    final pageNumber = ref.watch(popularMoviesWithGenresPageNumberProvider);
    return popularMoviesWithGenresRepo.getPopularMoviesWithGenres(
      listOfGenres,
      pageNumber,
    );
  },
);
