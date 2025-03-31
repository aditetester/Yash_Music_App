import 'dart:async';

import 'package:boilerplate_new_version/domain/usecase/categories/get_category_usecase.dart';
import 'package:boilerplate_new_version/domain/usecase/music_list/get_musicList_usecase.dart';
import 'package:boilerplate_new_version/domain/usecase/sub_categories/get_subcategories_usecase.dart';
import 'package:boilerplate_new_version/presentation/categories/store/categories_store.dart';
import 'package:boilerplate_new_version/presentation/music/store/music_list_store.dart';
import 'package:boilerplate_new_version/presentation/musicPlayer/store/musicController/music_controller_store.dart';
import 'package:boilerplate_new_version/presentation/subCategories/store/sub_categories_store.dart';

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
      ThemeStore(
        getIt<SettingRepository>(),
        getIt<ErrorStore>(),
      ),
    );
    
     getIt.registerSingleton<CategoryStore>(
      CategoryStore(  getIt<GetCategoryUseCase>(),
        getIt<ErrorStore>(),),
    );
     getIt.registerSingleton<SubCategoriesStore>(
      SubCategoriesStore(getIt<GetSubCategoryUseCase>(),
        getIt<ErrorStore>(),));

      getIt.registerSingleton<MusicListStore>(
      MusicListStore(getIt<GetMusiclistUsecase>(),
        getIt<ErrorStore>(),));


      getIt.registerSingleton<MusicControllerStore>(
      MusicControllerStore(
        getIt<SettingRepository>(),
        getIt<ErrorStore>(),
      ));

  }
}
