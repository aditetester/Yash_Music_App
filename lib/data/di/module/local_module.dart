import 'dart:async';

import 'package:boilerplate_new_version/core/data/Local/dataBase_Helper2.dart';
import 'package:boilerplate_new_version/core/data/local/database_helper.dart';
import 'package:boilerplate_new_version/data/network/local/downloaded_list.dart';
import 'package:boilerplate_new_version/data/network/local/music_playlist.dart';

import '../../sharedpref/shared_preference_helper.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../di/service_locator.dart';

class LocalModule {
  static Future<void> configureLocalModuleInjection() async {
    //Local:---------------------------------------------------------------
    getIt.registerSingleton<MusicPlayerDBHelper>(MusicPlayerDBHelper());
    getIt.registerSingleton<MusicPlayListDBHelper>(MusicPlayListDBHelper());

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

    getIt.registerSingleton<MusicPlaylistApi>(
      MusicPlaylistApi(getIt<MusicPlayListDBHelper>()),
    );
  }
}
