import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_verse/constants/extensions.dart';
import '../../../constants/strings.dart';
import '../../../providers/home_screen_provider.dart';
import '../../theme/theme.dart';


class HomeScreen extends ConsumerWidget{
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = context.textTheme();
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    final homeScreenProviderResponse = ref.watch(homeScreenProvider);


    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => const GenreSelectionScreen(),
          //   ),
          // );
        },
        label: Text(
          homeScreenFAB,
          style: textTheme!.titleMedium!.copyWith(color: darkAccent),
        ),
      ),
      body: Center(
        child: Text('Home Screen'),
      ),
    );
  }

}