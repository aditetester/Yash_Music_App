import 'dart:async';
import 'package:boilerplate_new_version/data/repository/categories/categories_respository_imp.dart';
import 'package:boilerplate_new_version/data/repository/subcategories/subCategories_respository_imp.dart';
import 'package:boilerplate_new_version/presentation/categories/store/categories_store.dart';
import 'package:boilerplate_new_version/presentation/subCategories/store/sub_categories_store.dart';

import '../../../core/stores/error/error_store.dart';
import '../../../core/stores/form/form_store.dart';
import '../../../domain/repository/setting/setting_repository.dart';
import '../../home/store/theme/theme_store.dart';

import '../../../di/service_locator.dart';

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
    
     getIt.registerSingleton<CategoriesStore>(
      CategoriesStore(getIt<CategoriesRepositoryImp>()),
    );
     getIt.registerSingleton<SubCategoriesStore>(
      SubCategoriesStore(getIt<SubCategoriesRepositoryImp>()),
    );
  }
}
