import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_verse/constants/strings.dart';
import 'services/shared_preferences.dart';
import 'views/theme/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then(
    (value) => runApp(
      DevicePreview(
        enabled: false,
        builder: (context) => const ProviderScope(
          child: MyApp(),
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<Widget> checkIfOpenedBefore() async {
    bool openedBefore = await SharedPreferenceServiceImpl().ifOpenedBefore();
    if (openedBefore) {
      return const HomeScreen();
    } else {
      return const OnboardingPage();
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        title: appName,
        theme: theme(),
        home: FutureBuilder(
          future: checkIfOpenedBefore(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return snapshot.data as Widget;
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: darkAccent,
                ),
              );
            }
          },
        ));
  }
}
