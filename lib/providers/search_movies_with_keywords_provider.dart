
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_verse/providers/page_number_providers.dart';

import '../models/search_movie_with_keyword_response_model.dart';
import '../repositories/search_movie_with_keywords_repo.dart';

final searchMoviesWithKeywordRepoProvider =
Provider((ref) => HttpSearchMoviesWithKeywords());

final searchMovieWithKeywordsProvider =
FutureProvider.autoDispose.family<SearchMovieWithKeywordResponse, String>(
        (ref, keywords) async {
        final searchMoviesWithKeywordRepo =
        ref.watch(searchMoviesWithKeywordRepoProvider);
        final pageNumber = ref.watch(searchMoviesWithKeywordsPageNumberProvider);

        return searchMoviesWithKeywordRepo.searchMovieWithKeywords(
            keywords, pageNumber,);
    },
);

final searchKeywordsProvider = StateProvider<String>((ref) => '');