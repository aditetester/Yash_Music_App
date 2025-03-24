import 'package:boilerplate_new_version/presentation/categories/all_categories.dart';
import 'package:boilerplate_new_version/presentation/categories/store/categories.dart';

import '../constants/app_theme.dart';
import '../constants/strings.dart';
import 'home/store/theme/theme_store.dart';
import '../utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../di/service_locator.dart';
import 'home/home.dart';
import 'package:boilerplate_new_version/presentation/splashScreen/splash_screen.dart';

class MyApp extends StatelessWidget {
  final ThemeStore _themeStore = getIt<ThemeStore>();
 

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: Strings.appName,
          theme:
              _themeStore.darkMode
                  ? AppThemeData.darkThemeData
                  : AppThemeData.lightThemeData,
          routes: Routes.routes,
          home:  HomeScreen(), //SplashScreen(),
          //path : SplashScreen() --> HomeScreen()
        );
      },
    );
  }
}
