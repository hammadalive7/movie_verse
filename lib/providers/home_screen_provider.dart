import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/home_response_model.dart';
import '../repositories/home_screen_repo.dart';

final homeScreenProvider = Provider<HomeScreenRepo>((ref) => HttpHomeScreenResponse());

final homeScreenProviderResponse = FutureProvider.autoDispose<HomeScreenResponse>((ref) async {
  final homeScreenRepo = ref.watch(homeScreenProvider);
  return homeScreenRepo.getHomeScreenResponse();
});