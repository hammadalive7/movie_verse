import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_verse/constants/extensions.dart';

import '../../../constants/strings.dart';
import '../../../helpers/process_genre_code.dart';
import '../../../helpers/process_image_link.dart';
import '../../../providers/page_number_providers.dart';
import '../../../providers/trending_movies_provider.dart';
import '../../components_shared/movie_card.dart';
import '../../components_shared/movie_list_shimmer_skeleton.dart';
import '../../components_shared/page_indecitor.dart';
import '../movie_details_screen/movie_details_screen.dart';

class TopRatedMoviesScreen extends ConsumerWidget {
  const TopRatedMoviesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme=context.textTheme();
    final width = MediaQuery.sizeOf(context).width;
    final pageNumber = ref.watch(topRatedMoviesNumberProvider);

    final moviesProvider =
        ref.watch(trendingMoviesProvider(pageNumber.toInt()));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          topRatedMovies,
          style: textTheme!.headlineSmall,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.02,
          // vertical: height * 0.001,
        ),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: moviesProvider.when(
                  data: (popularMoviesResponse) => Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: popularMoviesResponse.results.length,
                          itemBuilder: (context, i) {
                            final movie = popularMoviesResponse.results[i];
                            return MovieCard(
                              movieName: movie.title,
                              moviePoster: ProcessImage.processImageLink(
                                movie.posterPath,
                              ),
                              movieReleaseDate: movie.releaseDate.toString(),
                              movieRating: movie.voteAverage.toString(),
                              movieGenres: ProcessGenreCode.processGenreCodes(
                                movie.genreIds,
                              ),
                              movieOverview: movie.overview,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MovieDetailsScreen(
                                      movieId: movie.id,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      PageIndicator(
                        currentPage: popularMoviesResponse.page,
                        totalPages: popularMoviesResponse.totalPages,
                        onTap: (int pageClicked) {
                          ref
                              .read(topRatedMoviesNumberProvider.notifier)
                              .setPageNumber(pageClicked);
                        },
                        scrollController: ScrollController(
                          initialScrollOffset:
                              (popularMoviesResponse.page - 1) *
                                  (width * 0.07 + width * 0.01),
                        ),
                      ),
                    ],
                  ),
                  error: (e, _) => Center(
                    child: Text(
                      wentWrong,
                      style: textTheme.titleMedium,
                    ),
                  ),
                  loading: () => const MovieListShimmerEffect(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
