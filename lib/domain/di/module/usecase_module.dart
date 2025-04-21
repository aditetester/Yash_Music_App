import 'dart:async';

import 'package:boilerplate_new_version/data/repository/categories/categories_respository_imp.dart';
import 'package:boilerplate_new_version/data/repository/downloadedList/downloaded_respository_imp.dart';
import 'package:boilerplate_new_version/data/repository/musicList/musicList_respository_imp.dart';
import 'package:boilerplate_new_version/data/repository/subcategories/subCategories_respository_imp.dart';

import 'package:boilerplate_new_version/domain/usecase/categories/get_category_usecase.dart';
import 'package:boilerplate_new_version/domain/usecase/downloaded_list/get_downloadedList_usecase.dart';
import 'package:boilerplate_new_version/domain/usecase/downloaded_list/insert_DownloadedList_usecase.dart';
import 'package:boilerplate_new_version/domain/usecase/music_list/get_musicList_usecase.dart';
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
  }
}
