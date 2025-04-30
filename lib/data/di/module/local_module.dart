import 'dart:async';
import 'package:boilerplate_new_version/core/data/Local/dataBase_Helper.dart';
import 'package:boilerplate_new_version/data/network/local/downloaded_list.dart';
import 'package:boilerplate_new_version/data/network/local/music_playlist.dart';
import 'package:boilerplate_new_version/data/network/local/recent_music_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../di/service_locator.dart';
import '../../sharedpref/shared_preference_helper.dart';

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

    getIt.registerSingleton<LocalDownloadedMusicList>(
      LocalDownloadedMusicList(getIt<MusicPlayerDBHelper>()),
    );

    getIt.registerSingleton<LocalMusicPlayList>(
      LocalMusicPlayList(getIt<MusicPlayerDBHelper>()),
    );
   
    getIt.registerSingleton<LocalRecentPlayList>(
      LocalRecentPlayList(getIt<MusicPlayerDBHelper>()),
    );
    
  }
}
