import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_verse/constants/extensions.dart';
import 'package:movie_verse/views/screens/home_screen/movie_list_horizontal.dart';
import '../../../constants/strings.dart';
import '../../../models/home_response_model.dart';
import '../../../providers/home_screen_provider.dart';
import '../../components_shared/movie_list_horizontal_shimmer_skeleton.dart';
import '../../theme/theme.dart';
import '../now_playing_movie_screen/now_playing_movies_screen.dart';
import '../popular_movie_screens/genres_selection_screen.dart';
import '../search_movies_with_keywords_screen/search_movies_with_keywords_screen.dart';
import '../top_rated_movie_screen/top_rated_movies_screen.dart';
import '../trending_movie_screen/trending_movies_sccreen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = context.textTheme();
    final width = MediaQuery
        .sizeOf(context)
        .width;
    final height = MediaQuery
        .sizeOf(context)
        .height;
    final homeScreenProviderResponse = ref.watch(homeScreenProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const GenreSelectionScreen(),
            ),
          );
        },
        label: Text(
          homeScreenFAB,
          style: textTheme?.titleMedium!.copyWith(color: darkAccent),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.03,
        ),
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      welcome,
                      style: Theme
                          .of(context)
                          .textTheme
                          .headlineSmall,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(
                      appName,
                      style:
                      Theme
                          .of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                        color: Color(0xFFFD7702),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SearchMoviesWithKeywordsScreen(
                        ),
                      ),
                    );
                  },
                  child: TextFormField(
                    enabled: false,
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Search Movies',
                      hintStyle:
                      Theme
                          .of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(
                        color: Colors.grey[400],
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: darkAccent,
                      ),
                      filled: true,
                      fillColor: Color(0xFF012A41),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      trendingMovies,
                      style: Theme
                          .of(context)
                          .textTheme
                          .headlineSmall,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TrendingMoviesScreen(),
                          ),
                        );
                      },
                      child: Text(
                        seeAll,
                        style:
                        Theme
                            .of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                          color: Color(0xFFFD7702),
                        ),
                      ),
                    ),
                  ],
                ),
                homeScreenProviderResponse.when(
                  data: (HomeScreenResponse homeScreenResponse) =>
                      HorizontalMoviesList(
                        movies: homeScreenResponse.trendingMovies,
                      ),
                  error: (e, _) =>
                      Center(
                        child: Text(
                          wentWrong,
                          style: Theme
                              .of(context)
                              .textTheme
                              .titleMedium,
                        ),
                      ),
                  loading: () => const HorizontalMovieListShimmerEffect(),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      nowPlayingMovies,
                      style: Theme
                          .of(context)
                          .textTheme
                          .headlineSmall,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                            const NowPlayingMoviesScreen(),
                          ),
                        );
                      },
                      child: Text(
                        seeAll,
                        style:
                        Theme
                            .of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                          color: Color(0xFFFD7702),
                        ),
                      ),
                    ),
                  ],
                ),
                homeScreenProviderResponse.when(
                  data: (HomeScreenResponse homeScreenResponse) =>
                      HorizontalMoviesList(
                        movies: homeScreenResponse.nowPlayingMovies,
                      ),
                  error: (e, _) =>
                      Center(
                        child: Text(
                          wentWrong,
                          style: Theme
                              .of(context)
                              .textTheme
                              .titleMedium,
                        ),
                      ),
                  loading: () => const HorizontalMovieListShimmerEffect(),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      topRatedMovies,
                      style: Theme
                          .of(context)
                          .textTheme
                          .headlineSmall,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TopRatedMoviesScreen(),
                          ),
                        );
                      },
                      child: Text(
                        seeAll,
                        style:
                        Theme
                            .of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                          color: Color(0xFFFD7702),
                        ),
                      ),
                    ),
                  ],
                ),
                homeScreenProviderResponse.when(
                  data: (HomeScreenResponse homeScreenResponse) =>
                      HorizontalMoviesList(
                        movies: homeScreenResponse.topRatedMovies,
                      ),
                  error: (e, _) =>
                      Center(
                        child: Text(
                          wentWrong,
                          style: Theme
                              .of(context)
                              .textTheme
                              .titleMedium,
                        ),
                      ),
                  loading: () => const HorizontalMovieListShimmerEffect(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
