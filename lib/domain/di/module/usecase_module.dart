import 'dart:async';

import 'package:boilerplate_new_version/data/repository/categories/categories_respository_imp.dart';
import 'package:boilerplate_new_version/data/repository/downloaded_list/downloaded_respository_imp.dart';
import 'package:boilerplate_new_version/data/repository/music_list/musicList_respository_imp.dart';
import 'package:boilerplate_new_version/data/repository/music_play_list/playlist_respository_imp.dart';
import 'package:boilerplate_new_version/data/repository/recent_play_list/recent_playlist_respository_imp.dart';
import 'package:boilerplate_new_version/data/repository/sub_categories/subCategories_respository_imp.dart';
import 'package:boilerplate_new_version/domain/repository/music_play_list/playList_repository.dart';
import 'package:boilerplate_new_version/domain/repository/recent_play_list/recent_play_list_repository.dart';

import 'package:boilerplate_new_version/domain/usecase/categories/get_category_usecase.dart';
import 'package:boilerplate_new_version/domain/usecase/downloaded_list/get_downloadedList_usecase.dart';
import 'package:boilerplate_new_version/domain/usecase/downloaded_list/insert_DownloadedList_usecase.dart';
import 'package:boilerplate_new_version/domain/usecase/music_list/get_musicList_usecase.dart';
import 'package:boilerplate_new_version/domain/usecase/music_play_list/get_music_playlist_usecase.dart';
import 'package:boilerplate_new_version/domain/usecase/music_play_list/insert_music_playlist_usecase.dart';
import 'package:boilerplate_new_version/domain/usecase/recent_play_list/delete_recent_playist_usecase.dart';
import 'package:boilerplate_new_version/domain/usecase/recent_play_list/get_recent_playist_usecase.dart';
import 'package:boilerplate_new_version/domain/usecase/recent_play_list/insert_recent_playist_usecase.dart';
import 'package:boilerplate_new_version/domain/usecase/sub_categories/get_subcategories_usecase.dart';

import '../../../di/service_locator.dart';

class UseCaseModule {
  static Future<void> configureUseCaseModuleInjection() async {
    // category:--------------------------------------------------------------------
    getIt.registerSingleton<GetCategoryUseCase>(
      GetCategoryUseCase(getIt<CategoriesRepositoryImp>()),
    );
    getIt.registerSingleton<GetSubCategoryUseCase>(
      GetSubCategoryUseCase(getIt<SubCategoriesRepositoryImp>()),
    );
    getIt.registerSingleton<GetMusiclistUsecase>(
      GetMusiclistUsecase(getIt<MusicListRepositoryImp>()),
    );
    getIt.registerSingleton<GetDownloadedMusiclistUsecase>(
      GetDownloadedMusiclistUsecase(getIt<DownloadedRespositoryImp>()),
    );
    getIt.registerSingleton<InsertMusicsUseCase>(
      InsertMusicsUseCase(getIt<DownloadedRespositoryImp>()),
    );

    getIt.registerSingleton<GetMusicPlayListUsecase>(
      GetMusicPlayListUsecase(getIt<PlayListRespositoryImp>()),
    );
    getIt.registerSingleton<InsertMusicsPlayListUseCase>(
      InsertMusicsPlayListUseCase(getIt<PlayListRespositoryImp>()),
    );

    getIt.registerSingleton<GetRecentPlayListUsecase>(
      GetRecentPlayListUsecase(getIt<RecentPlayListRespositoryImp>()),
    );
    getIt.registerSingleton<InsertRecentPlayListUseCase>(
      InsertRecentPlayListUseCase(getIt<RecentPlayListRespositoryImp>()),
    );
      getIt.registerSingleton<DeleteRecentPlayListUseCase>(
      DeleteRecentPlayListUseCase(getIt<RecentPlayListRespositoryImp>()),
    );
  }
}
