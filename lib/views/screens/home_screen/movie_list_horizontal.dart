import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:movie_verse/constants/assets.dart';
import '../../../helpers/process_image_link.dart';
import '../../../models/movie_model.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';

import '../movie_details_screen/movie_details_screen.dart';

class HorizontalMoviesList extends StatelessWidget {
  final List<Movie> movies;

   HorizontalMoviesList({super.key, required this.movies});

  static final customCacheManager = CacheManager(
    Config(
      'customCacheKey',
      stalePeriod: const Duration(days: 2),
      maxNrOfCacheObjects: 200,
    ),
  );

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;



    return SizedBox(
        height: 345,
        width: double.infinity,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final movie = movies[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MovieDetailsScreen(
                              movieId: movie.id,
                            ),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: width * 0.4,
                        height: height * 0.25,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),

                          child: CachedNetworkImage(
                            placeholder: (context, url) => Image.asset(
                              placeholder,
                              fit: BoxFit.cover,
                            ),
                            imageUrl: ProcessImage.processPosterLink(
                              movie.posterPath,
                            ),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                            key: UniqueKey(),
                            cacheManager: customCacheManager,
                            fit: BoxFit.cover,
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      SizedBox(
                        width: width * 0.3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                            const SizedBox(height: 5.0),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 15.0,
                                ),
                                const SizedBox(width: 5.0),
                                Text(
                                  movie.voteAverage.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}
