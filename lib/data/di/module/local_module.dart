import 'dart:async';

import 'package:boilerplate_new_version/core/data/local/database_helper.dart';
import 'package:boilerplate_new_version/data/network/local/downloaded_list.dart';

import '../../sharedpref/shared_preference_helper.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../di/service_locator.dart';

class LocalModule {
  static Future<void> configureLocalModuleInjection() async {
    //Local:---------------------------------------------------------------
    getIt.registerSingleton<MusicPlayerDBHelper>(MusicPlayerDBHelper());

    // preference manager:------------------------------------------------------
    getIt.registerSingletonAsync<SharedPreferences>(
      SharedPreferences.getInstance,
    );
    getIt.registerSingleton<SharedPreferenceHelper>(
      SharedPreferenceHelper(await getIt.getAsync<SharedPreferences>()),
    );

    getIt.registerSingleton<DownloadedMusicListApi>(
      DownloadedMusicListApi(getIt<MusicPlayerDBHelper>()),
    );
  }
}
