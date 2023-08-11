import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/home_response_model.dart';
import '../repositories/home_screen_repo.dart';

final homeScreenRepoProvider = Provider<HomeScreenRepo>((ref) {
  return HttpHomeScreenResponse();
});

final homeScreenProvider = FutureProvider.autoDispose<HomeScreenResponse>((ref) async {
  final homeScreenRepo = ref.watch(homeScreenRepoProvider);
  return homeScreenRepo.getHomeScreenResponse();
});
