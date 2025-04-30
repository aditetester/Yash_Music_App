import 'dart:async';
import 'package:boilerplate_new_version/data/network/apis/lyrics/LyricsPlayer_api.dart';
import 'package:boilerplate_new_version/domain/usecase/categories/get_category_usecase.dart';
import 'package:boilerplate_new_version/domain/usecase/downloaded_list/get_downloadedList_usecase.dart';
import 'package:boilerplate_new_version/domain/usecase/downloaded_list/insert_DownloadedList_usecase.dart';
import 'package:boilerplate_new_version/domain/usecase/music_list/get_musicList_usecase.dart';
import 'package:boilerplate_new_version/domain/usecase/music_play_list/get_music_playlist_usecase.dart';
import 'package:boilerplate_new_version/domain/usecase/music_play_list/insert_music_playlist_usecase.dart';
import 'package:boilerplate_new_version/domain/usecase/music_play_list_category/get_category_playlist_usecase.dart';
import 'package:boilerplate_new_version/domain/usecase/music_play_list_category/insert_category_playlist_usecase.dart';
import 'package:boilerplate_new_version/domain/usecase/recent_play_list/delete_recent_playist_usecase.dart';
import 'package:boilerplate_new_version/domain/usecase/recent_play_list/get_recent_playist_usecase.dart';
import 'package:boilerplate_new_version/domain/usecase/recent_play_list/insert_recent_playist_usecase.dart';
import 'package:boilerplate_new_version/domain/usecase/sub_categories/get_subcategories_usecase.dart';
import 'package:boilerplate_new_version/presentation/categories/store/categories_store.dart';
import 'package:boilerplate_new_version/presentation/home/store/homeController/home_store.dart';
import 'package:boilerplate_new_version/presentation/downloaded_music_list/store/download_list_store.dart';
import 'package:boilerplate_new_version/presentation/music/store/music_list_store.dart';
import 'package:boilerplate_new_version/presentation/music_playlist_screen/store/music_playlist_store.dart';
import 'package:boilerplate_new_version/presentation/music_player/store/musicController/music_controller_store.dart';
import 'package:boilerplate_new_version/presentation/recent_play_list/store/recent_music_list_store.dart';
import 'package:boilerplate_new_version/presentation/sub_categories/store/sub_categories_store.dart';

import '../../../core/stores/error/error_store.dart';
import '../../../core/stores/form/form_store.dart';
import '../../../di/service_locator.dart';
import '../../../domain/repository/setting/setting_repository.dart';
import '../../home/store/theme/theme_store.dart';

class StoreModule {
  static Future<void> configureStoreModuleInjection() async {
    // factories:---------------------------------------------------------------
    getIt.registerFactory(() => ErrorStore());
    getIt.registerFactory(() => FormErrorStore());
    getIt.registerFactory(
      () => FormStore(getIt<FormErrorStore>(), getIt<ErrorStore>()),
    );
    // stores:------------------------------------------------------------------

    getIt.registerSingleton<ThemeStore>(
      ThemeStore(getIt<SettingRepository>(), getIt<ErrorStore>()),
    );
    getIt.registerSingleton<HomeControllerStore>(HomeControllerStore());
    getIt.registerSingleton<CategoryStore>(
      CategoryStore(getIt<GetCategoryUseCase>(), getIt<ErrorStore>()),
    );
    getIt.registerSingleton<SubCategoriesStore>(
      SubCategoriesStore(getIt<GetSubCategoryUseCase>(), getIt<ErrorStore>()),
    );

    getIt.registerSingleton<MusicControllerStore>(
      MusicControllerStore(
        getIt<LyricsApi>(),
        getIt<SettingRepository>(),
        getIt<ErrorStore>(),
      ),
    );

    getIt.registerSingleton<MusicListStore>(
      MusicListStore(getIt<GetMusiclistUsecase>(), getIt<ErrorStore>()),
    );

    getIt.registerSingleton<DownloadListStore>(
      DownloadListStore(
        getIt<GetDownloadedMusiclistUsecase>(),
        getIt<InsertMusicsUseCase>(),
        getIt<ErrorStore>(),
        getIt<LyricsApi>(),
      ),
    );

    getIt.registerSingleton<MusicPlayListStore>(
      MusicPlayListStore(
        getIt<GetCategoryPlayListUsecase>(),
        getIt<InsertCategoryPlayListUseCase>(),
        getIt<GetMusicPlayListUsecase>(),
        getIt<InsertMusicsPlayListUseCase>(),
        getIt<ErrorStore>(),
        getIt<LyricsApi>(),
      ),
    );

    getIt.registerSingleton<RecentMusicListStore>(
      RecentMusicListStore(
        getIt<GetRecentPlayListUsecase>(),
        getIt<DeleteRecentPlayListUseCase>(),
        getIt<InsertRecentPlayListUseCase>(),
        getIt<ErrorStore>(),
        getIt<LyricsApi>(),
      ),
    );
  }
}
