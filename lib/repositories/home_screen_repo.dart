import 'package:movie_verse/models/home_response_model.dart';
import 'package:movie_verse/services/client/base_client.dart';



abstract class HomeScreenRepo {
  Future<HomeScreenResponse> getHomeScreenResponse();
}

class HttpHomeScreenResponse implements HomeScreenRepo {
  @override
  Future<HomeScreenResponse> getHomeScreenResponse() async {
    HomeScreenResponse homeScreenResponse;
    final Map<String, dynamic> response = await BaseClient().getHomeFromMovieDB();
    homeScreenResponse = HomeScreenResponse.fromJson(response);
    return homeScreenResponse;
  }
}