import 'dart:async';
import 'package:boilerplate_new_version/data/network/apis/posts/post_api.dart';
import 'package:boilerplate_new_version/data/repository/all_categories/categories_respository_imp.dart';
import 'package:boilerplate_new_version/domain/repository/categories/Categories_repository.dart';
import 'package:boilerplate_new_version/presentation/categories/store/categories.dart';

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
    
     getIt.registerSingleton<Categories>(
      Categories(getIt<CategoriesRepositoryImp>()),
    );
  }
}
