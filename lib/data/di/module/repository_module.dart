import 'dart:async';

import 'package:boilerplate_new_version/data/network/apis/categories/categories_api.dart';
import 'package:boilerplate_new_version/data/network/apis/musicList/musicList_api.dart';
import 'package:boilerplate_new_version/data/network/apis/subCategories/subCategories_api.dart';
import 'package:boilerplate_new_version/data/network/local/downloaded_list.dart';
import 'package:boilerplate_new_version/data/network/local/music_playlist.dart';
import 'package:boilerplate_new_version/data/network/local/recent_music_list.dart';
import 'package:boilerplate_new_version/data/repository/categories/categories_respository_imp.dart';
import 'package:boilerplate_new_version/data/repository/downloadedList/downloaded_respository_imp.dart';
import 'package:boilerplate_new_version/data/repository/musicList/musicList_respository_imp.dart';
import 'package:boilerplate_new_version/data/repository/musicPlayList/playlist_respository_imp.dart';
import 'package:boilerplate_new_version/data/repository/recent_play_list/recent_playlist_respository_imp.dart';
import 'package:boilerplate_new_version/data/repository/subcategories/subCategories_respository_imp.dart';

import '../../../di/service_locator.dart';
import '../../../domain/repository/setting/setting_repository.dart';
import '../../repository/setting/setting_repository_impl.dart';
import '../../sharedpref/shared_preference_helper.dart';

class RepositoryModule {
  static Future<void> configureRepositoryModuleInjection() async {
    // repository:--------------------------------------------------------------
    getIt.registerSingleton<SettingRepository>(SettingRepositoryImpl(
      getIt<SharedPreferenceHelper>(),
    ));
    
    getIt.registerSingleton<CategoriesRepositoryImp>(CategoriesRepositoryImp(
      getIt<CategoriesApi>(),
    ));
     
     getIt.registerSingleton<SubCategoriesRepositoryImp>(SubCategoriesRepositoryImp(
      getIt<SubCategoriesApi>(),
    ));

     getIt.registerSingleton<MusicListRepositoryImp> (MusicListRepositoryImp(
      getIt<MusicListApi>(),
    ));

   getIt.registerSingleton<DownloadedRespositoryImp> (DownloadedRespositoryImp(
      getIt<LocalDownloadedMusicList>(),
    ));
     getIt.registerSingleton<PlayListRespositoryImp> (PlayListRespositoryImp(
      getIt<LocalMusicPlayList>(),
    ));
    getIt.registerSingleton<RecentPlayListRespositoryImp> (RecentPlayListRespositoryImp(
      getIt<LocalRecentPlayList>(),
    ));
  }
}
