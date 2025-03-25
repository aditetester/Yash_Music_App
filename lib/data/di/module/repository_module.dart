import 'dart:async';

import 'package:boilerplate_new_version/data/network/apis/categories/categories_api.dart';
import 'package:boilerplate_new_version/data/network/apis/subCategories/subCategories_api.dart';
import 'package:boilerplate_new_version/data/repository/categories/categories_respository_imp.dart';
import 'package:boilerplate_new_version/data/repository/subcategories/subCategories_respository_imp.dart';
import 'package:boilerplate_new_version/domain/repository/categories/Categories_repository.dart';
import 'package:boilerplate_new_version/domain/repository/subCategories/subCategories_respository.dart';

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
  }
}
