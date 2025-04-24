import 'package:boilerplate_new_version/presentation/home/home.dart';
import 'package:boilerplate_new_version/presentation/music/music_list.dart';
import 'package:boilerplate_new_version/presentation/musicPlayer/musicPlayer_screen.dart';
import 'package:sizer/sizer.dart';
import '../constants/app_theme.dart';
import '../constants/strings.dart';
import 'home/store/theme/theme_store.dart';
import '../utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../di/service_locator.dart';
import 'package:boilerplate_new_version/presentation/splashScreen/splash_screen.dart';

class MyApp extends StatelessWidget {
  final ThemeStore _themeStore = getIt<ThemeStore>();
 

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return Sizer(
          builder: (context, orientation, deviceType) => MaterialApp(
            // showSemanticsDebugger: true,
            debugShowCheckedModeBanner: false,
            title: Strings.appName,
            theme:
                _themeStore.darkMode
                    ? AppThemeData.darkThemeData
                    : AppThemeData.lightThemeData,
            routes: Routes.routes,
            home:  SplashScreen(), //SplashScreen(),
          ),
        );
      },
    );
  }
}

//path : SplashScreen() --> HomeScreen() --> CategoryList() --> SubCategoryList() --> MusicList() --> MusicPlayer()
