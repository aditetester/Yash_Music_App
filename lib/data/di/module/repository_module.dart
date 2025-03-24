import 'dart:async';
import 'package:boilerplate_new_version/data/network/apis/posts/post_api.dart';
import 'package:boilerplate_new_version/data/repository/all_categories/categories_respository_imp.dart';
import '../../repository/setting/setting_repository_impl.dart';
import '../../sharedpref/shared_preference_helper.dart';
import '../../../domain/repository/setting/setting_repository.dart';
import '../../../di/service_locator.dart';

class RepositoryModule {
  static Future<void> configureRepositoryModuleInjection() async {
    // repository:--------------------------------------------------------------
    getIt.registerSingleton<SettingRepository>(SettingRepositoryImpl(
      getIt<SharedPreferenceHelper>(),
    ));
    
    getIt.registerSingleton<CategoriesRepositoryImp>(CategoriesRepositoryImp(
      getIt<PostApi>(),
    ));

  }
}
