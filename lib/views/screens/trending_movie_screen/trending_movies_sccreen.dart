import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_verse/constants/extensions.dart';
import '../../../constants/strings.dart';
import '../../../helpers/process_image_link.dart';
import '../../../providers/page_number_providers.dart';
import '../../../providers/trending_movies_provider.dart';
import '../../components_shared/movie_card.dart';
import '../../components_shared/movie_list_shimmer_skeleton.dart';
import '../../components_shared/page_indecitor.dart';
import '../../components_shared/process_genre_code.dart';

class TrendingMoviesScreen extends ConsumerWidget {
  const TrendingMoviesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = context.textTheme();
    final width = MediaQuery.sizeOf(context).width;
    final pageNumber = ref.watch(trendingMoviesPageNumberProvider);

    final moviesProvider =
        ref.watch(trendingMoviesProvider(pageNumber.toInt()));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          trendingMovies,
          style: textTheme?.headlineSmall,
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
                data: (trendingMoviesResponse) => Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: trendingMoviesResponse.results.length,
                        itemBuilder: (context, i) {
                          final movie = trendingMoviesResponse.results[i];
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
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => MovieDetailsScreen(
                              //       movieId: movie.id,
                              //     ),
                              //   ),
                              // );
                            },
                          );
                        },
                      ),
                    ),
                    PageIndicator(
                      currentPage: trendingMoviesResponse.page,
                      totalPages: trendingMoviesResponse.totalPages,
                      onTap: (int pageClicked) {
                        ref
                            .read(trendingMoviesPageNumberProvider.notifier)
                            .setPageNumber(pageClicked);
                      },
                      scrollController: ScrollController(
                        initialScrollOffset:
                        (trendingMoviesResponse.page - 1) *
                            (width * 0.07 + width * 0.01),
                      ),
                    ),
                  ],
                ),
                error: (e, _) => Center(
                  child: Text(
                    wentWrong,
                    style: textTheme?.titleMedium,
                  ),
                ),
                loading: () => const MovieListShimmerEffect(),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
