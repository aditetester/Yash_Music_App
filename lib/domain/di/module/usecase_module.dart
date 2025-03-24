import 'dart:async';

import 'package:boilerplate_new_version/domain/repository/categories/Categories_repository.dart';
import 'package:boilerplate_new_version/domain/usecase/post/get_post_usecase.dart';

import '../../../di/service_locator.dart';

class UseCaseModule {
  static Future<void> configureUseCaseModuleInjection() async {
   
    // post:--------------------------------------------------------------------
    getIt.registerSingleton<GetPostUseCase>(
      GetPostUseCase(getIt<CategoriesRepository>()),
    );
    
  }
}
