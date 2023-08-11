import 'package:flutter/material.dart';

import '../models/now_playing_movies_response_model.dart';
import '../services/client/base_client.dart';


abstract class NowPlayingMoviesRepo {
  Future<NowPlayingMoviesResponse> getNowPlayingMoviesResponse([int page = 1]);
}

class HttpNowPlayingMoviesRepo implements NowPlayingMoviesRepo {
  @override
  Future<NowPlayingMoviesResponse> getNowPlayingMoviesResponse([
    int page = 1,
  ]) async {
    NowPlayingMoviesResponse nowPlayingMoviesResponse;
    final String uri =
        '/movie/now_playing?language=en-US&page=${page.toString()}';
    final Map<String, dynamic> response = await BaseClient().get(uri);
    debugPrint(response.toString());
    nowPlayingMoviesResponse = NowPlayingMoviesResponse.fromJson(response);
    return nowPlayingMoviesResponse;
  }
}
